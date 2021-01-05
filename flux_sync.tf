# flux_sync data source generates a multi-doc YAML containing the GitRepository and Kustomization manifests that configure Flux to sync the cluster with the specified repository

locals {
  k8s_resources_name  = "flux-system"
  namespace           = "echo"
}

resource "kubernetes_namespace" "main" {
  metadata {
    name = local.namespace
  }
}

# Generate manifests
data "flux_sync" "main" {
  target_path = "releases"
  url         = "https://github.com/${var.github_owner}/${var.repository_name}"
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

# Apply manifests on the cluster
resource "kubectl_manifest" "sync" {
  for_each  = { for v in data.kubectl_file_documents.sync.documents : sha1(v) => v }
  depends_on = [kubectl_manifest.apply, kubernetes_namespace.flux_system, kubernetes_namespace.main]

  yaml_body = each.value
}

# Generate a Kubernetes secret with the Git credentials
resource "kubernetes_secret" "main" {
  depends_on = [kubectl_manifest.apply]

  metadata {
    name      = data.flux_sync.main.name
    namespace = data.flux_sync.main.namespace
  }

  data = {
    username = "git"
    password = var.github_token
  }
}
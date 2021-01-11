# flux_sync data source generates a multi-doc YAML containing the GitRepository and Kustomization manifests that configure Flux to sync the cluster with the specified repository

locals {
  repositories  = {for r in var.repositories: r.name => r}
  documents     = flatten([
    for repository_key, repository in local.repositories : [
      for document_key, document in data.kubectl_file_documents.sync[repository_key].documents : document
    ]
  ])
}

resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "kubernetes_namespace" "main" {
  for_each = local.repositories
  metadata {
    name = each.value.namespace
  }
}

# Generate manifests
data "flux_sync" "main" {
  for_each    = local.repositories
  target_path = each.value.target_path
  url         = "${var.gitlab_base_url}/${each.value.owner}/${each.value.name}"
  namespace   = each.value.namespace
  branch      = each.value.branch
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "sync" {
  for_each  = local.repositories
  content   = data.flux_sync.main[each.key].content
}

# Apply manifests on the cluster
resource "kubectl_manifest" "sync" {
  for_each    = { for v in local.documents : sha1(v) => v }
  depends_on  = [kubectl_manifest.apply, kubernetes_namespace.flux_system, kubernetes_namespace.main]

  yaml_body   = each.value
}

# Generate a Kubernetes secret with the Git credentials
resource "kubernetes_secret" "main" {
  for_each    = local.repositories
  depends_on  = [kubectl_manifest.apply]

  metadata {
    name      = data.flux_sync.main[each.key].name
    namespace = kubernetes_namespace.main[each.key].metadata.0.name
  }

  data = {
    username        = "git"
    password        = var.gitlab_token
    known_hosts     = var.known_hosts
    identity        = tls_private_key.main.private_key_pem
    "identity.pub"  = tls_private_key.main.public_key_pem
  }
}

resource "gitlab_deploy_key" "main" {
  for_each  = local.repositories
  project   = each.value.id
  title     = "Flux deploy key"
  key       = tls_private_key.main.public_key_openssh
  can_push  = true
}
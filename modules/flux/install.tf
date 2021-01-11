# flux_install data source generates a multi-doc YAML with Kubernetes manifests that can be used to install or upgrade Flux.

# Generate manifests
data "flux_install" "main" {
  target_path    = "production"
  arch           = "amd64"
  network_policy = false
  version        = "latest"
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

# Split multi-doc YAML with
# https://registry.terraform.io/providers/gavinbunney/kubectl/latest
data "kubectl_file_documents" "apply" {
  content = data.flux_install.main.content
}

# Apply manifests on the cluster
resource "kubectl_manifest" "apply" {
  for_each  = { for v in data.kubectl_file_documents.apply.documents : sha1(v) => v }
  depends_on = [kubernetes_namespace.flux_system]

  yaml_body = each.value
}
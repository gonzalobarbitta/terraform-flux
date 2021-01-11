output "manifests" {
  description = "Manifests applied on the cluster"
  value = kubectl_manifest.apply
}

output "namespace" {
  description = "Namespace where manifests are installed"
  value = kubernetes_namespace.flux_system
}
variable "namespace" {
  type          = string
  default       = "flux-system"
  description   = "The namespace scope for install manifests"
}

variable "repositories" {
  description = "Repositories that Flux will sync with the cluster"
  type        = set(object({
    namespace   = string
    name        = string
    branch      = string
    target_path = string
  }))
}

variable "github_token" {
  description = "The GitHub personal access token."
  type        = string
}

variable "github_owner" {
  description = "The GitHub account to manage."
  type        = string
}

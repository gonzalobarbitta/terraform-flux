variable "namespace" {
  type          = string
  default       = "flux-system"
  description   = "The namespace scope for install manifests"
}

variable "repositories" {
  description = "Repositories that Flux will sync with the cluster"
  type        = set(object({
    namespace   = string
    owner       = string
    name        = string
    branch      = string
    target_path = string
    id          = number
  }))
}

variable "known_hosts" {
  description = "The contents of an SSH known_hosts file."
  type        = string
}

variable "gitlab_token" {
  description = "The GitLab personal access token."
  type        = string
}

variable "gitlab_base_url" {
  description = "The target GitLab base API endpoint."
  type        = string
}
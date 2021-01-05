variable "github_owner" {
  type = string
  default = "gonzalobarbitta"
}

variable "github_token" {
  type = string
}

variable "repository_name" {
  type    = string
  default = "flux2"
}

variable "repository_visibility" {
  type    = string
  default = "private"
}

variable "branch" {
  type    = string
  default = "main"
}
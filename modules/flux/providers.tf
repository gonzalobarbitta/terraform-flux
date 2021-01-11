terraform {
  required_version = ">= 0.13"

  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.13.3"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.0.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.9.1"
    }
  }
}

provider "flux" {}

provider "kubectl" {}

provider "kubernetes" {}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = "${var.gitlab_base_url}/api/v4/"
}
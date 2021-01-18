locals {
  github_owner = "gonzalobarbitta"
  repositories    = [
    {
      namespace   = "httpbin"
      name        = "httpbin"
      branch      = "main"
      target_path = "releases"
    }
  ]
}

module "flux" {
  source        = "./modules/flux"
  repositories  = local.repositories
  github_token  = var.github_token
  github_owner  = local.github_owner
}
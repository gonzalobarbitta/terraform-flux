locals {
  repositories    = [
    {
      namespace   = "echo"
      owner       = "gb43580"
      name        = "echo-chart"
      branch      = "master"
      target_path = "releases"
      id          = 407
    },
    {
      namespace   = "httpbin"
      owner       = "gb43580"
      name        = "httpbin-chart"
      branch      = "master"
      target_path = "releases"
      id          = 408
    }
  ]
}

module "flux" {
  source        = "./modules/flux"
  repositories  = local.repositories
  gitlab_token  = var.gitlab_token
}
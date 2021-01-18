# terraform-flux
Uses Terraform provider for Flux v2 to install Flux on k8s and configure it to reconcile the cluster state from (at least) one Git repository.

For details on usage, please see the [chart readme](https://gitlab.bindg.com/gb43580/terraform-flux/modules/flux).

In this example, it syncs cluster with one repository: https://github.com/gonzalobarbitta/httpbin
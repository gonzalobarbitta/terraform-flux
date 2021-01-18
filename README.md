# terraform-flux
Uses Terraform provider for Flux v2 to install Flux on k8s and configure it to reconcile the cluster state from (at least) one Git repository.

For details on usage, please see the [chart readme](https://github.com/gonzalobarbitta/terraform-flux/tree/main/modules/flux).

This example syncs cluster with one repository: https://github.com/gonzalobarbitta/httpbin

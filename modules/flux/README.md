# Flux2
Provides data sources to bootstrap a Kubernetes cluster with Flux, and manifests for reconciling one or more GitHub repositories on the cluster from the same owner.

## Configuration

The following tables lists the configurable parameters of the chart and their default values.

| Parameter                                         | Default                                              | Description
| -----------------------------------------------   | ---------------------------------------------------- | ---
| `repositories`                                    | `[]`                                                 | Git repositories where the sync manifests are committed.
| `github_token`                                    | `""`                                                 | The GitHub personal access token with `api` scope. Ideally, access token tied to a service account used for multiple repositories.
| `github_base_url`                                 | `""`                                                 | The target GitHub base endpoint.
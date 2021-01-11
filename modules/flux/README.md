# Flux2
Provides data sources to bootstrap a Kubernetes cluster with Flux, and manifests for reconciling one or more Gitlab repositories on the cluster.

## Configuration

The following tables lists the configurable parameters of the chart and their default values.

| Parameter                                         | Default                                              | Description
| -----------------------------------------------   | ---------------------------------------------------- | ---
| `repositories`                                    | `[]`                                                 | Git repositories where the sync manifests are committed.
| `known_hosts`                                     | `""`                                                 | When using a private Git host, contents of its host key.
| `gitlab_token`                                    | `""`                                                 | The GitLab personal access token with `api` scope. Ideally, access token tied to a service account used for multiple repositories.
| `gitlab_base_url`                                 | `""`                                                 | The target GitLab base endpoint.
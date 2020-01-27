# Redis module

This module can be used to quickly get a redis up and running according to Entur conventions

## Main effect

Creates a redis instance named **team-app-namespace-suffix**: `${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.redis_instance_suffix}`.

## Side effects

Generated Kubernetes Config Map:

- `${var.labels.app}-redis-configmap` with `{ REDIS_HOST: "host of redis" }`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gcp_project | The name of your GCP project | string | n/a | yes |
| zone | The name of your default zone | string | n/a | yes |
| labels | The labels you wish to decorate with | string | n/a | yes |
| labels.team | The name of your team or department | string | n/a | yes |
| labels.app | The name of this appliation / workload | string | n/a | yes |
| reserved_ip_range | The reserved IP range in CIDR notation | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. Note, this is only here to allow separate envs to have different redis instances. They do not actually live in the namespace. | string | n/a | yes |
| redis_instance_suffix | The suffix of this redis instance | string | "redis" | no |


## Outputs

| Name | Description |
|------|-------------|
| none | n/a |
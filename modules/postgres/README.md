# Postgres module

This module can be used to quickly get a postgresql up and running according to Entur conventions

## Main effect

Creates a postgresql named **team-app-namespace-suffix**: `${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.db_instance_suffix}`.

## Side effects

Generated Kubernetes Secrets:

- `${var.labels.app}-db-credentials` with `{ username: "PG_USER", password: "PG_PASSWORD" }`
- `${var.labels.app}-instance-credentials` with `{ credentials.json: "PRIVATEKEY" }`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gcp_project | The name of your GCP project | string | n/a | yes |
| region | The default region | string | n/a | yes |
| zoneLetter | The default zone [a,b,c,d,e etc] | string | n/a | yes |
| labels | The labels you wish to decorate with | string | n/a | yes |
| labels.team | The name of your team or department | string | n/a | yes |
| labels.app | The name of this appliation / workload | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sql-db-generated-user-password | The database password, also stored in ${var.labels.app}-db-credentials |
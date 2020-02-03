# Postgres module

This module can be used to quickly get a postgresql up and running according to Entur conventions

## Main effect

Creates a postgresql named **team-app-namespace-suffix**: `${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.db_instance_suffix}`.

## Side effects

### Generated Service Account:

- `${var.labels.app}-${var.kubernetes_namespace}-cred`
  - `[app]-[namespace]-cred`
  - Name of the Service Account used by this postgresql database
  - Render: `aweomeblog-production-cred`
      - team = `ninja`
      - app = `awesomeblog`
      - namespace = `production`

### Generated Kubernetes Secrets:

- `${var.labels.app}-db-credentials` with `{ username: "PG_USER", password: "PG_PASSWORD" }`
  - **[app]-db-credentials**
  - Contains the username and password of the database
  - Render: `awesomeblog-db-credentials`
    - given
      - app = `awesomeblog`
- `${var.labels.app}-instance-credentials` with `{ credentials.json: "PRIVATEKEY", INSTANCES: "CLOUDSQL_CONNECTION_STRING" }`
  - `[app]-instance-credentials`
  - Contains the credentials.json service account credentials and the connection string used by cloudsql_proxy
  - Render: `awesomeblog-instance-credentials`
    - given
      - app = `awesomeblog`

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
| prevent_destroy | Prevents the destruction of the bucket | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| sql-db-generated-user-password | The database password, also stored in ${var.labels.app}-db-credentials |
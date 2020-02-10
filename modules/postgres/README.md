# Postgres module

This module can be used to quickly get a postgresql up and running according to Entur conventions

## Main effect

Creates a postgresql named **app-namespace-suffix**: `${var.labels.app}-${var.kubernetes_namespace}-${auto_random_suffix}`.

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
| labels.app | The name of this application / workload | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string | n/a | yes |
| db_name | Name of the default database | string | n/a | yes |
| db_user | Default user for database | string | n/a | yes |
| prevent_destroy | Prevents the destruction of the bucket | bool | false | no |
| postgresql_version | Which version to use | string | "POSTGRES_9_6" | no |
| db_instance_custom_name | Database instance name override | string | "" | no |
| db_instance_backup_enabled | Enable database backup | bool | true | no |
| db_instance_backup_time | When the backup should be scheduled | string | "04:00" | no |
| db_instance_tier | The tier for the master instance | string | "db-custom-1-3840" | no |
| db_instance_disk_size | The disk size for the master instance | string | "10" | no |
| create_timeout | The optional timout that is applied to limit long database creates | string | "10m" | no |
| delete_timeout | The optional timout that is applied to limit long database deletes | string | "10m" | no |
| update_timeout | The optional timout that is applied to limit long database updates | string | "10m" | no |

> FYI: The auto-resize flag is set. `db_instance_disk_size` only takes effect on initial apply. If manual resize is required, use the Google Console.
> 
>[Accepted Postgres db tiers](https://cloud.google.com/sql/docs/postgres/create-instance#machine-types) that can be used. Default `db_instance_tier` has 1 CPU and 3,75Gb RAM. 

## Outputs

| Name | Description |
|------|-------------|
| sql-db-generated-user-password | The database password, also stored in ${var.labels.app}-db-credentials |
| sql-db-instance_name | The database instance name |
| sql-db-instance_connection_name | The database instance connection name |
| sql-db-instance_self_link | The database instance self link |

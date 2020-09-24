# Postgres module

This module can be used to quickly get an IBM database up and running according to Entur conventions

## Main effect

Creates an IBM database for postgreSQL and mongoDB.

## Side effects

### Generated Kubernetes Secrets:

- `${var.labels.app}-db-credentials` with `{ username: "USERNAME", password: "PASSWORD", name: "DATABASE_NAME", host: "DB_HOSTNAME", host2: "DB_HOSTNAME2"*, port: "DB_PORT", args: "DB_CONNECTION_ARGS", cert: "DB_CERT" }`
  - `[app]-instance-credentials`
  - Contains the username, password and connection information used to conenct to the database
  - Render: `awesomeblog-instance-credentials`
    - given
      - app = `awesomeblog`
  - *only for MongoDB

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| labels | The labels you wish to decorate with | string | n/a | yes |
| labels.team | The name of your team or department | string | n/a | yes |
| labels.app | The name of this application / workload | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string | n/a | yes |
| db_instance_name | Name of the database instance | string | n/a | yes |
| region | The default region | string | osl01 | no |
| application_db_user | Default application user | string | app-user | no |
| prevent_destroy | Prevents the destruction of the database instance | bool | false | no |
| db_type | The database type to provision* | string | databases-for-postgresql | no |
| db_instance_plan | The database payment plan | string | standard | no |
| db_version | Which version to use** | string | "12" | no |
| db_instance_disk_size_mb | The disc size for the database instance*** | string | "5120" | no |
| db_instance_memory_mb | The allocated memory for the database instance | string | "1024"| no |
| create_timeout | The optional timeout that is applied to limit long database creates | string | "60m" | no |
| delete_timeout | The optional timeout that is applied to limit long database deletes | string | "20m" | no |
| update_timeout | The optional timeout that is applied to limit long database updates | string | "10m" | no |

  *Available(tested) parameters: "databases-for-postgresql" and "databases-for-mongodb".

  **Use major versions. You can find the latest versions from the [catalog pages](https://cloud.ibm.com/catalog?category=databases)

  ***MongoDB requires minimum 20480 mb disc size.

## Outputs

| Name | Description |
|------|-------------|
| db-generated-application-password | The database password, also stored in ${var.labels.app}-db-credentials |
| db-host_name | The database instance name (2 hosts for MongoDB) |

Find more in [official documentation](https://cloud.ibm.com/docs/terraform?topic=terraform-databases-resources)

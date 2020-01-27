# Bucket module

This module can be used to quickly get a bucket up and running according to Entur conventions

## Main effect

Creates a bucket named **app-nam-suffix**: `${var.labels.app}-${substr(var.kubernetes_namespace,0,3)}-${var.bucket_instance_suffix}`.

> NB: The total length of the bucket name cannot exceed 30 characters.

## Side effects

Generated Kubernetes Secrets:

- `${var.labels.app}-db-credentials` with `{ username: "PG_USER", password: "PG_PASSWORD" }`
- `${var.labels.app}-instance-credentials` with `{ credentials.json: "PRIVATEKEY" }`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| gcp_project | The name of your GCP project | string | n/a | yes |
| location | The location of your bucket | string | n/a | yes |
| labels | The labels you wish to decorate with | string | n/a | yes |
| labels.team | The name of your team or department | string | n/a | yes |
| labels.app | The name of this appliation / workload | string | n/a | yes |
| location | The location of your bucket | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string | n/a | yes |
| bucket_instance_suffix | A suffix that is added to the bucket, this can be used as a workaround for destroying and creating a bucket (naming collision) | string | "bucket" | no |
| storage_class | The storage class of the bucket | string | "RGIONAL" | no |
| versioning | Should bucket be versioned? | bool | true | no |
| log_bucket | The bucket's Access & Storage Logs configuration | bool | false | no |
| bucket_policy_only | Enables Bucket Policy Only access to a bucket | bool | false | no |
| service_account_bucket_role | Role of the Service Account | string | "READER" | no |

## Outputs

| Name | Description |
|------|-------------|
| sql-db-generated-user-password | The database password, also stored in ${var.labels.app}-db-credentials |
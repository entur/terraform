# Bucket module

This module can be used to quickly get a bucket up and running according to Entur conventions

## Main effect

Creates a bucket named **team-app-namespace-suffix**: `${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.bucket_instance_suffix}`.

> NB: The total length of the bucket name cannot exceed 30 characters.

## Side effects

### Generated Service Account:

- `${var.labels.app}-${substr(var.kubernetes_namespace,0,3)}-${var.bucket_instance_suffix}`
  - `[app]-[nam(espace)]-[suffix]`
  - Name of the Service Account used by this bucket (name length < 30)
  - Render: `awesome-pro-bucket`
    - given
      - app = `awesomeblog`
      - namespace = `production`
      - suffix = `bucket`

This seems odd, but stems from the fact that bucket SA cannot be named more than 30 characters longl

### Generated Kubernetes Secrets:

- `${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.bucket_instance_suffix}-credentials` with `{ credentials.json: "PRIVATEKEY" }`
  - `[team]-[app]-[namespace]-[suffix]-credentials`
  - Contains the credentials.json service account credentials
  - Render: `ninja-blog-dev-bucket-credentials`
    - given
      - team = `ninja`
      - app = `awesomeblog`
      - namespace = `production`
      - suffix = `bucket`

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
| prevent_destroy | Prevents the destruction of the bucket | bool | n/a | yes |
| bucket_instance_suffix | A suffix that is added to the bucket, this can be used as a workaround for destroying and creating a bucket (naming collision) | string | "bucket" | no |
| storage_class | The storage class of the bucket | string | "RGIONAL" | no |
| versioning | Should bucket be versioned? | bool | true | no |
| log_bucket | The bucket's Access & Storage Logs configuration | bool | false | no |
| bucket_policy_only | Enables Bucket Policy Only access to a bucket | bool | false | no |
| service_account_bucket_role | Role of the Service Account | string | "READER" | no |

## Outputs

| Name | Description |
|------|-------------|
| google_storage_bucket_name | The bucket name |
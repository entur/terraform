# Bucket module

This module can be used to quickly get a bucket up and running according to Entur conventions

## Main effect

Creates a bucket named **app-namespace-suffix**: `${var.labels.app}-${var.kubernetes_namespace}`.

> NB: The total length of the bucket name cannot exceed 30 characters.

## Side effects

### Generated Service Account:

- `${var.labels.app}-${var.kubernetes_namespace}`
  - `[app]-[namespace]`
  - Name of the Service Account used by this bucket (name length < 30)
  - Render: `awesome-pro-bucket`
    - given
      - app = `awesomeblog`
      - namespace = `production`

### Generated Kubernetes Secrets:

- `${var.labels.app}-bucket-credentials` with `{ credentials.json: "PRIVATEKEY" }`
  - `[app]-[namespace]-bucket-credentials`
  - Contains the credentials.json service account credentials
  - Render: `blog-bucket-credentials`
    - given
      - app = `awesomeblog`
      - namespace = `production`

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
| prevent_destroy | Prevents the destruction of the bucket | bool | false | no |
| storage_class | The storage class of the bucket | string | "REGIONAL" | no |
| versioning | Should bucket be versioned? | bool | true | no |
| log_bucket | The bucket's Access & Storage Logs configuration | bool | false | no |
| bucket_policy_only | Enables Bucket Policy Only access to a bucket | bool | false | no |
| service_account_bucket_role | Role of the Service Account | string | "roles/storage.objectViewer" | no |
| account_id | Storage service account id (name) override | string | "" | no |
| account_id_use_existing | Set this to true if you want to use an existing service account | bool | false | no |

## Outputs

| Name | Description |
|------|-------------|
| google_storage_bucket_name | The bucket name |
# Secret module

This module can be used to quickly get a secret up and running according to Entur conventions

## Main effect

Creates a secret in `var.kubernetes_namespace` named `var.secret_name` with data `var.secret_data` that is decorated with `var.labels`.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| secret_name | Name of this secret | string | n/a | yes |
| secret_data | Name of this secret | map(string) | n/a | yes |
| kubernetes_namespace | Namespace of this secret | string | n/a | 
| labels | The labels you wish to decorate with | string | n/a | yes |yes |

## Outputs

| Name | Description |
|------|-------------|
|  n/a |  |
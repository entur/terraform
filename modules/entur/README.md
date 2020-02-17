# Entur convention compliance module

This module is used to check whether Terraform resources are set up according to Entur conventions.

## Main effect

Checks for the existence of required labels, fails to plan if any are missing.

## Inputs
### Labels variable
Entur's conventions require you to provide certain labels in the format of a map containing strings. E.g.:

```
variable "labels" {
  type        = map(string)
  default = {
    app     = "foo"
    team    = "bar"
  }
}
````

#### Required labels:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| labels.app | App name | string | n/a | yes |
| labels.team | Team name | string | n/a | yes |
| labels.slack | Slack channel used to communicate about this resource | string | n/a | yes |
| labels.type | Resource type (e.g. database, api) | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
|  n/a |  |
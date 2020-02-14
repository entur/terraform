# Entur convention compliance module

This module is used to check whether Terraform resources are set up according to Entur conventions.

## Main effect

Checks for the existence of required labels, fails to plan if any are missing.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| labels | The labels you wish to decorate with | string | n/a | yes | yes |

## Outputs

| Name | Description |
|------|-------------|
|  n/a |  |
# Namespace module

This module can be used to set up namespaces for teams.

## Main effect

Creates a namespace named `${var.kubernetes_namespace}` or `env-${var.kubernetes_namespace}` if `branch_environment` is set to `true`.

If you specify a reserved namespace such as `default`, `dev`, `staging` or `production` no namespace will be created, and terraform will raise an error.

## Inputs

| Name                 | Description                                                                                |  Type  | Default | Required |
| -------------------- | ------------------------------------------------------------------------------------------ | :----: | :-----: | :------: |
| labels               | The labels you wish to decorate with                                                       | string |   n/a   |   yes    |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string |   n/a   |   yes    |
| branch_environment   | Set false if the intention is a long lived namespace                                       |  bool  |  true   |    no    |

## Outputs

| Name                  | Description          |
| --------------------- | -------------------- |
| module.namespace.name | The namespace itself |

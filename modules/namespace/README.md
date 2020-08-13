# Namespace module

This module can be used to set up namespaces for teams.

## Main effect

Creates a namespace named `${var.kubernetes_namespace}` or `${var.master_override}` if the kubernetes namespace is set to master.
The reason for this override is because the current convention for environment default builds are to build from master.
With this override, we can continue this practice and simply override the resulting namespace per environment with a tfvars override.

If you specify a reserved namespace such as `default`, `dev`, `staging` or `production` no namespace will be created.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| labels | The labels you wish to decorate with | string | n/a | yes |
| labels.team | The name of your team or department | string | n/a | yes |
| labels.app | The name of this application / workload | string | n/a | yes |
| kubernetes_namespace | The namespace you wish to target. This is the namespace that the secrets will be stored in | string | n/a | yes |
| master_override | The namespace you wish to target for a master build. | string | production | yes |

## Outputs

| Name | Description |
|------|-------------|
| module.namespace.kubernetes_namespace.environment[0] | The namespace itself |

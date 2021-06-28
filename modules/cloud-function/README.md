# cloud function module

This module can be used to quickly add cloud functions

## Example

> module "function" {
>     source               = "github.com/entur/terraform//master/modules/cloud-function"
>    project              = var.gcp_project
>    function_name        = "nameoffunction"
>    function_entry_point = "nameoffunction"
>    function_source      = "src"
>    runtime              = "python39"
>}
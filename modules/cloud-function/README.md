# cloud function module

This module can be used to quickly add cloud functions

## Example

module "deploy_function" {
    source               = "github.com/entur/terraform//master/modules/cloud-function"
    project              = var.gcp_project
    function_name        = "nameoffuntion"
    function_entry_point = "nameoffuntion"
    function_source      = "src"
    runtime              = "python39"
}
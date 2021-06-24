# cloud function module

This module can be used to quickly add cloud functions

## Example

module "deploy_auth0_metrics" {
    source               = "github.com/entur/terraform/blob/master/modules/cloud-function"
    project              = var.gcp_project
    function_name        = "nameoffuntion"
    function_entry_point = "nameoffuntion"
    function_source      = "src"
    runtime              = "python39"
}

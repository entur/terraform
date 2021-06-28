# cloud function module

This module can be used to quickly add cloud functions

## Example

        module "function" {
            source               = "github.com/entur/terraform//master/modules/cloud-function"
            project              = var.gcp_project
            function_name        = "nameoffunction"
            function_entry_point = "nameoffunction"
            function_source      = "src"
            runtime              = "python39"
        }
        
## Exlaination
        
* function_source -> Content on catalog *src* is copied to cloud-function   
* runtime -> Cloud function runtime (python/nodejs/jave). See terraform documentation for google_cloudfunctions_function
* function_name -> gcp name for function
* function_entry_point -> function name end entry point (use same as function_name)

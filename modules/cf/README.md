# cloud function module

This module can be used to quickly add cloud functions

## initial code 

### Create bucket that will host the source code
	resource "google_storage_bucket" "bucket" {
	  name      = "cloudfunction-deploy-tf"
	  project   = var.gcp_project
	}
	
All functions need same bucket for updload with name: *cloudfunction-deploy-tf* 		


## Example http_funtion

        module "cf/http_function" {
            source               = "github.com/entur/terraform//master/modules/cf/http-function"
            project              = var.gcp_project
            function_name        = "name_off_function"
            function_entry_point = "name_off_function"
            function_source      = "src_http_code"
            runtime              = "python39"
        }
        
### Explain
        
	* function_source -> Content on catalog *src* is copied to cloud-function   
	* runtime -> Cloud function runtime (python/nodejs/jave). See terraform documentation for google_cloudfunctions_function
	* function_name -> gcp name for function
	* function_entry_point -> function name end entry point (use same as function_name)


## Example http_funtion

        module "cf/pubsub_function" {
            source               = "github.com/entur/terraform//master/modules/cf/pubsub-function"
            project              = var.gcp_project
            function_name        = "name_off_function"
            function_entry_point = "name_off_function"
            function_source      = "src_pubsub_code"
            runtime              = "nodejs10"
            event_topic          = "topic_name"
        }
        
### Explain
        
	* function_source -> Content on catalog *src* is copied to cloud-function   
	* runtime -> Cloud function runtime (python/nodejs/jave). See terraform documentation for google_cloudfunctions_function
	* function_name -> gcp name for function
	* function_entry_point -> function name end entry point (use same as function_name)
	* event_topic -> "name of topic" -> pubsub topic is created if not exists


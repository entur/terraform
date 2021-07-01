locals {
    timestamp = formatdate("YYMMDDhhmmss", timestamp())
	  root_dir = abspath("../") 
}

# Compress source code
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${local.root_dir}/${var.function_source}"
  output_path = "/tmp/function-${local.timestamp}.zip"
}

# Add source code zip to bucket
resource "google_storage_bucket_object" "zip" {
  # Append file MD5 to force bucket to be recreated
  name   = "source.zip#${data.archive_file.source.output_md5}"
  bucket = "cloudfunction-deploy-tf"
  source = data.archive_file.source.output_path
}

# Enable Cloud Functions API
resource "google_project_service" "cf" {
  project = var.project
  service = "cloudfunctions.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Enable Cloud Build API
resource "google_project_service" "cb" {
  project = var.project
  service = "cloudbuild.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = false
}

# Create http Cloud Function
resource "google_cloudfunctions_function" "http_trigger" {
  
  project               = var.project
  region                = var.region
  labels                = var.labels 

  name                  = var.function_name

  environment_variables = var.environment_variables
  
  runtime               = var.runtime
  timeout               = var.timeout
  available_memory_mb   = var.run_memmory

  source_archive_bucket = google_storage_bucket_object.zip.bucket
  source_archive_object = google_storage_bucket_object.zip.name
  trigger_http          = true
  entry_point           = var.function_entry_point
  
  depends_on = [
      google_storage_bucket_object.zip
    ]

}

# Create IAM entry so all users can invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.project
  region         = var.region
  cloud_function = var.function_name
  role           = "roles/cloudfunctions.invoker"
  member         = "allUsers"

    depends_on = [
      google_cloudfunctions_function.http_trigger
    ]

}
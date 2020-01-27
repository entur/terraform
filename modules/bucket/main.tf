terraform {
  required_version = ">= 0.12"
}

provider "kubernetes" {
  version = "~> 1.10"
  # host    = "127.0.0.1:8001" // kubectl proxy
}

provider "google" {
  version = "~> 2.19"
}


# Create bucket
resource "google_storage_bucket" "storage_bucket" {
  name               = "${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.bucket_instance_suffix}"
  force_destroy      = false
  location           = var.location
  project            = var.gcp_project
  storage_class      = var.storage_class
  bucket_policy_only = var.bucket_policy_only
  labels             = var.labels

  versioning {
    enabled = var.versioning
  }
  logging {
    log_bucket        = var.log_bucket
    log_object_prefix = "${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.bucket_instance_suffix}"
  }
}

# Create Service account
resource "google_service_account" "storage_bucket_service_account" {
  # this can be maximum 30 chars long - shorten namespace staging => sta and do not list teamname
  account_id   = "${var.labels.app}-${substr(var.kubernetes_namespace,0,3)}-${var.bucket_instance_suffix}"
  display_name = "Service Account for ${var.labels.team}: ${var.labels.app} app bucket"
  project      = var.gcp_project
}

# Create key for service account
resource "google_service_account_key" "storage_bucket_service_account_key" {
  service_account_id = google_service_account.storage_bucket_service_account.name
}

# Add SA key to kubernetes
resource "kubernetes_secret" "storage_bucket_service_account_credentials" {
  depends_on = [
    google_storage_bucket.storage_bucket
  ]
  metadata {
    name      = "${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.bucket_instance_suffix}-credentials"
    namespace = var.kubernetes_namespace
  }
  data = {
    "credentials.json" = "${base64decode(google_service_account_key.storage_bucket_service_account_key.private_key)}"
  }
}

# add service account as member to the bucket
resource "google_storage_bucket_access_control" "storage_bucket_access_control" {
  bucket = google_storage_bucket.storage_bucket.name
  role   = var.service_account_bucket_role
  entity = "user-${google_service_account.storage_bucket_service_account.email}"
}

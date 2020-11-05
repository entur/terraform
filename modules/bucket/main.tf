terraform {
  required_version = ">= 0.12"
}

provider "google" {
  version = "~> 2.19"
  project = var.gcp_project
}

# https://www.terraform.io/docs/providers/google/r/storage_bucket.html
resource "google_storage_bucket" "storage_bucket" {
  name               = length(var.bucket_instance_custom_name) > 0 ? var.bucket_instance_custom_name : "${var.labels.app}-${var.kubernetes_namespace}-${random_id.suffix.hex}"
  force_destroy      = var.force_destroy
  location           = var.location
  project            = var.gcp_project
  storage_class      = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels             = var.labels

  versioning {
    enabled = var.versioning
  }
  logging {
    log_bucket        = var.log_bucket
    log_object_prefix = length(var.bucket_instance_custom_name) > 0 ? var.bucket_instance_custom_name : "${var.labels.app}-${var.kubernetes_namespace}-${random_id.suffix.hex}"
  }
}

resource "random_id" "protector" {
  count       = var.prevent_destroy ? 1 : 0
  byte_length = 8
  keepers = {
    protector = google_storage_bucket.storage_bucket.id
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "random_id" "suffix" {
  byte_length = 2
}

# Create Service account
resource "google_service_account" "storage_bucket_service_account" {
  count = var.account_id_use_existing == true ? 0 : 1
  account_id   = length(var.account_id) > 0 ? var.account_id : "${var.labels.app}-${var.kubernetes_namespace}"
  display_name   = length(var.account_id) > 0 ? var.account_id : "${var.labels.app}-${var.kubernetes_namespace}"
  description = "Service Account for ${var.labels.app} bucket"
  project = var.gcp_project
}

# Create key for service account
resource "google_service_account_key" "storage_bucket_service_account_key" {
  service_account_id = var.account_id_use_existing == true ? var.account_id : google_service_account.storage_bucket_service_account[0].name
}

# Add SA key to kubernetes
resource "kubernetes_secret" "storage_bucket_service_account_credentials" {
  depends_on = [
    google_storage_bucket.storage_bucket
  ]
  metadata {
    name      = "${var.labels.app}-bucket-credentials"
    namespace = var.kubernetes_namespace
  }
  data = {
    "credentials.json" = "${base64decode(google_service_account_key.storage_bucket_service_account_key.private_key)}"
  }
}

# Add service account as member to the bucket
resource "google_storage_bucket_iam_member" "storage_bucket_iam_member" {
  count = var.account_id_use_existing == true ? 0 : 1
  bucket = google_storage_bucket.storage_bucket.name
  role   = var.service_account_bucket_role
  member = "serviceAccount:${google_service_account.storage_bucket_service_account[0].email}"
}

variable "gcp_project" {
  description = "The GCP project id"
}

variable "location" {
  description = "GCP bucket location"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  #   default = {
  #     manager = "terraform"
  #     team    = "TEAM"
  #     slack   = "talk-TEAM"
  #     app     = "SERVICE"
  #   }
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

variable "force_destroy" {
  description = "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run"
  default     = false
}

variable "storage_class" {
  description = "GCP storage class"
  default     = "REGIONAL"
}

variable "versioning" {
  description = "The bucket's Versioning configuration."
  default     = "true"
}

variable "log_bucket" {
  description = "The bucket's Access & Storage Logs configuration"
  default     = "false"
}

variable "uniform_bucket_level_access" {
  description = "Enables Uniform bucket-level access to a bucket"
  default     = "false"
}

variable "service_account_bucket_role" {
  description = "Role of the Service Account - more about roles https://cloud.google.com/storage/docs/access-control/iam-roles"
  default     = "roles/storage.objectViewer"
}

variable "prevent_destroy" {
  description = "Prevent destruction of bucket"
  type        = bool
  default     = false
}

variable "account_id" {
  description = "Bucket service account id override (empty string = use standard convention)"
  default     = ""
}

variable "account_id_use_existing" {
  description = "Set this to true if you want to use an existing service account, otherwise a new one will be created (account_id must also be provided if set to true)"
  default     = false
}

variable "bucket_instance_custom_name" {
  description = "Bucket instance name override (empty string = use standard convention)"
  default     = ""
}

variable "kubernetes_credential_file_name" {
  description = "File name of the kubernetes secrets file containing the created service account credentials."
  default     = "${var.labels.app}-bucket-credentials"
}
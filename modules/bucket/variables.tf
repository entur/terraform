variable "gcp_project" {
  description = "The GCP project id"
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

variable "bucket_instance_suffix" {
  description = "A suffix for the bucket instance, may be changed if environment is destroyed and then needed again (name collision workaround)"
  default     = "bucket"
}

variable "location" {
  description = "GCP bucket location"
  default     = "europe-west1"
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

variable "bucket_policy_only" {
  description = "Enables Bucket Policy Only access to a bucket."
  default     = "false"
}

variable "service_account_bucket_role" {
  description = "Role of the Service Account"
  default     = "READER"
}

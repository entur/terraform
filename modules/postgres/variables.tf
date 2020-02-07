#
# Variables that needs a value
#
variable "gcp_project" {
  description = "The GCP project id"
}

variable "region" {
  description = "GCP default region"
}

variable "zoneLetter" {
  description = "GCP default zone"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  #default = {
  #  team    = "TEAM"
  #  app     = "SERVICE"
  #}
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

variable "db_name" {
  description = "Name of the default database"
}

variable "db_user" {
  description = "Default user for postgres db"
}

#
# Variables with default value
#
variable "prevent_destroy" {
  description = "Prevent the destruction of this postgres database"
  type        = bool
  default     = false
}

variable "postgresql_version" {
  description = "Which POSTGRES version to use. Check availability before declaring any version."
  default     = "POSTGRES_9_6"
}

variable "db_instance_custom_name" {
  description = "Database instance name override (empty string = use standard convention)"
  default     = ""
}

variable "db_instance_backup_enabled" {
  description = "Enable database backup"
  default     = true
}

variable "db_instance_backup_time" {
  description = "When the backup should be scheduled"
  default     = "04:00"
}

variable "db_instance_tier" {
  description = "DB default tier"
  default     = "db-f1-micro"
}

variable "db_instance_disk_size" {
  description = "DB disc size"
  default     = "10"
}

# Timeouts
variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  default     = "10m"
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  default     = "10m"
}

variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  default     = "10m"
}

#
# Variables that needs a value
#
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

variable "db_instance_name" {
  description = "Database instance name override (empty string = use standard convention)"
  default     = ""
}

#
# Variables with default value
#
variable "region" {
  description = "GCP default region"
  type        = string
  default     = "osl01"
}

variable "application_db_user" {
  description = "Application user for the postgres db"
  type        = string
  default     = "app-user"
}

variable "prevent_destroy" {
  description = "Prevent the destruction of this postgres database"
  type        = bool
  default     = false
}

variable "db_type" {
  description = "Database type such as postgres or mongodb"
  type        = string
  default     = "databases-for-postgresql"
}

variable "db_instance_plan" {
  description = "The database pricing plan"
  type        = string
  default     = "standard"
}

variable "db_version" {
  description = "Database version"
  type        = string
  default     = "12"
}

variable "db_instance_disk_size_mb" {
  description = "DB disc size in MB"
  type        = string
  default     = "16384"
}

variable "db_instance_memory_mb" {
  description = "DB memory size in MB"
  type        = string
  default     = "2048"
}

# Timeouts
variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  default     = "60m"
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  default     = "20m"
}

variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  default     = "10m"
}

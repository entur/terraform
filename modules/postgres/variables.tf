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
  #  manager = "terraform"
  #  team    = "TEAM"
  #  slack   = "talk-TEAM"
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

variable "postgresql_version" {
  description = "Which POSTGRES version to use. Check availability before declaring any version."
  default     = "POSTGRES_9_6"
}

variable "db_instance_custom_name" {
  description = "Database instance name override (empty string = disabled)"
  default     = ""
}

variable "db_instance_suffix" {
  description = "A static suffix for the database instance name"
  default     = "postgres"
}

variable "db_instance_random_suffix_append" {
  description = "Append additional random suffix to database instance name, to avoid name collision"
  type        = bool
  default     = true
}

variable "db_instance_random_suffix_length" {
  description = "Random database instance name suffix length (in bytes, i.e. 2 bytes = 4 char)"
  default     = 2
}

variable "db_instance_backup_enabled" {
  description = "Enable database backup"
  default     = true
}

variable "db_instance_backup_time" {
  description = "When the backup should be scheduled"
  default     = "04:00"
}

variable "prevent_destroy" {
  description = "Prevent the destruction of this postgres database"
  type        = bool
  default     = false
}




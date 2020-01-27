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

variable "db_instance_suffix" {
  description = "A suffix for the database instance, may be changed if environment is destroyed and then needed again (name collision workaround)"
  default     = "postgres"
}

variable "db_instance_backup_enabled" {
  description = "Enable database backup"
  default     = true
}

variable "db_instance_backup_time" {
  description = "When the backup should be scheduled"
  default     = "04:00"
}




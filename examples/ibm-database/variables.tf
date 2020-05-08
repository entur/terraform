variable "load_config_file" {
    default = false
}

variable "db_type" {
    description = "Select a database type"
    default = "databases-for-postgresql" 
}

variable "db_instance_name" {
  description = "Database instance name override (empty string = use standard convention)"
  default     = "example-db"
}

variable "kubernetes_namespace" {
    description = "Your kubernetes namespace" 
}

variable "db_version" {
  description = "Database version"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  default = {
    manager = "terraform"
    team    = "your-team"
    slack   = "talk-team"
    app     = "example-app"
  }
}




variable "gcp_project" {
  description = "The GCP project id"
}

variable "region" {
  description = "Target GCP region"
  type        = string
  default     = "europe-west1"
}

variable "zone_letter" {
  description = "Letter of target GCP zone"
  type        = string
  default     = "d"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  default = {
    manager = "terraform"
    team    = "teamname"
    slack   = "talk-teamname"
    app     = "testpgv4"
  }
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

variable "prevent_destroy" {
  description = "Prevent the destruction of this postgres database"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "example"
}

variable "db_user" {
  description = "Name of the database user"
  type        = string
  default     = "example-user"
}

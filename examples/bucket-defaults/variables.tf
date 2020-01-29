variable "gcp_project" {
  description = "The GCP project id"
}

variable "location" {
  description = "GCP bucket location"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  default = {
    manager = "terraform"
    team    = "teamname"
    slack   = "talk-teamname"
    app     = "service"
  }
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
  default     = "default"
}

variable "prevent_destroy" {
  description = "Prevent destruction of bucket"
  type        = bool
}

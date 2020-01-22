
variable "gcp_project" {
  description = "The GCP project id"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = "map"
  default = {
    manager = "terraform"
    team    = "TEAM"
    slack   = "talk-TEAM"
    app     = "SERVICE"
  }
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

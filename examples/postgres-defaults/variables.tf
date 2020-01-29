
variable "gcp_project" {
  description = "The GCP project id"
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
}

variable "prevent_destroy" {
  description = "Prevent the destruction of this postgres database"
  type        = bool
}

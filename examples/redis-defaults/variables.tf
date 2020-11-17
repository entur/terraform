variable "gcp_project" {
  description = "The GCP project id"
}

variable "region" {
  description = "GCP default region"
}

variable "zoneLetter" {
  description = "GCP default zone"
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
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
variable "redis_reserved_ip_range" {
  description = "IP range for Redis, follow addressing scheme"
  default     = "10.110.20.8/29"
}

variable "prevent_destroy" {
  description = "Prevents destruction of this redis instance"
  type        = bool
}

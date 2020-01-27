variable "gcp_project" {
  description = "The GCP project id"
}

variable "zone" {
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




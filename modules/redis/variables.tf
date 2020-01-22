variable "gcp_project" {
  description = "The GCP project id"
}

variable "zone" {
  description = "GCP default zone"
  default     = "europe-west1-d"
}

variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  #default = {
  #  manager = "terraform"
  #  team    = "varelager"
  #  slack   = "talk-varelager"
  #  app     = "inventory"
  #
}

variable "reserved_ip_range" {
  description = "IP range for Redis, check Confluence `IP addressing scheme`"
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

variable "gcp_project" {
  description = "The GCP project id"
}

variable "zone" {
  description = "GCP default zone"
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

variable "redis_instance_suffix" {
  description = "A suffix for the database instance, may be changed if environment is destroyed and then needed again (name collision workaround)"
  default     = "redis"
}
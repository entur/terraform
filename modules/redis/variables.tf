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

variable "redis_configs" {
  description = "Redis configuration settings."
  type = map(string)
  default = {
    activedefrag = "yes"
    maxmemory-policy = "allkeys-lfu"
  }
}

variable "reserved_ip_range" {
  description = "IP range for Redis, check Confluence `IP addressing scheme`"
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
}

variable "redis_instance_custom_name" {
  description = "Redis instance name override (empty string = use standard convention)"
  default     = ""
}

variable "prevent_destroy" {
  description = "Prevents destruction of this redis instance"
  type        = bool
  default     = false
}

variable "enable_apis" {
  description = "Flag for enabling redis API in your project"
  type        = bool
  default     = false
}

variable "authorized_network_name_override" {
  description = "Redis instance authorized network name override (empty string = use standard convention)"
  default     = ""
}

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

variable "disable_on_destroy" {
  description = "Disable the service when the terraform resource is destroyed"
  type        = bool
  default     = false
}

variable "disable_dependent_services" {
  description = "Services that are enabled and which depend on this service should also be disabled when this service is destroyed. "
  type        = bool
  default     = false
}
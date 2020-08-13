variable "labels" {
  description = "Labels matching Entur's standards"
  type        = map(string)
}

variable "reserved_namespaces" {
  description = "Reserved namespaces"
  type        = list(string)
  default = [
    "master",
    "default",
    "dev",
    "test",
    "stage",
    "staging",
    "prod",
    "production"
  ]
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
  default     = "default"
}

variable "master_override" {
  description = "Master branch equals namespace"
  default     = "production"
}

variable "labels" {
  description = "Labels matching Entur's standards"
  type        = map(string)
}

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace, prefixed by `env-` if branch_environment=true"
}

variable "reserved_namespaces" {
  description = "Reserved namespaces"
  type        = list(string)
  default = [
    "master",
    "main",
    "rtd",
    "default",
    "dev",
    "test",
    "stage",
    "staging",
    "prod",
    "production"
  ]
}

variable "branch_environment" {
  description = "Master branch equals namespace"
  type        = bool
  default     = true
}

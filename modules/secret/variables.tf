variable "labels" {
  description = "labels used in all resources"
  type        = map(string)
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "secret_data" {
  description = "Secret data"
  type        = map(string)
}

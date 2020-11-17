variable "labels" {
  description = "Labels matching Entur's standards"
  type        = map(string)
}

# TODO: input validation
# https://www.terraform.io/docs/configuration/variables.html
variable "kubernetes_namespace" {
  description = "Your kubernetes namespace, prefixed by `env-` if branch_environment=true"

  validation {
    condition = contains([
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
    ], var.kubernetes_namespace) ? false : true
    error_message = "Your kubernetes_namespace must not be a reserved namespace."
  }
}

variable "branch_environment" {
  description = "Master branch equals namespace"
  type        = bool
  default     = true
}

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

# This will typically be populated by Harness to match your branch name
variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
  default     = "feature-TEST1"
}
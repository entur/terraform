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

variable "kubernetes_namespace" {
  description = "Your kubernetes namespace"
  default     = "demo-ns" # creeates env-demo-ns namespace!
}

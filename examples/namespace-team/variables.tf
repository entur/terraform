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
  default     = "master"
}

variable "master_override" {
  description = "Master branch equals namespace"
  default     = "teamname"
}

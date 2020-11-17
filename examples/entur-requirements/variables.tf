
variable "labels" {
  description = "Labels used in all resources"
  type        = map(string)
  default = {
    team        = "your-team"
    slack       = "talk-team"
    app         = "example-app"
    type        = "backend"
    environment = "production"
  }
}

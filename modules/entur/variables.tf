

variable "labels" {
  description = "Labels matching Entur's standards"
  type        = map(string)

  validation {
    condition     = length(var.labels.app) > 0 && length(var.labels.team) > 0 && length(var.labels.slack) > 0 && length(var.labels.type) > 0
    error_message = "You must provide these labels: app, team, slack, type."
  }
}

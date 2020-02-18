terraform {
  required_version = ">= 0.12"
}

resource "null_resource" "label_exists_app" {
  count = length(var.labels.app) > 0 ? 1 : "Entur requires you to provide a labels.app value, this is the name of your application"
}

resource "null_resource" "label_exists_team" {
  count = length(var.labels.team) > 0 ? 1 : "Entur requires you to provide a labels.team value, this is the name of your team"
}

resource "null_resource" "label_exists_slack" {
  count = length(var.labels.slack) > 0 ? 1 : "Entur requires you to provide a labels.slack value, this is the Slack channel used to communicate about this resource"
}

resource "null_resource" "label_exists_type" {
  count = length(var.labels.type) > 0 ? 1 : "Entur requires you to provide a labels.type value, which describes the resource type (e.g. backend/frontend/database/queue/proxy)"
}

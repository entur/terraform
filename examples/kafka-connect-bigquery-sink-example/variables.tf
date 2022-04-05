# Define your variables in this file
# You can override them in your tfvar files per envinronment

variable "gcp_project" {
  description = "GCP project id"
}

variable "cluster_name" {
  description = "GCP cluster name"
}

variable "region" {
  description = "GCP default region"
  default     = "europe-west1"
}

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace in which to create a given resource"
}

variable "bigquery_project" {
  description = "GCP BigQuery project id"
  type        = string
}

variable "kafka_topics" {
  description = "List of kafka topic names to sink data from"
  type        = list(string)
}

variable "repo" {
  description = "Name of the repo"
}

variable "team" {
  description = "Name of the team that owns this sink connector"
}

variable "team_slack" {
  description = "Name of the team's slack channel"
}

variable "pd_key" {
  description = "Pagerduty integration key"
  type        = string
}

variable "instance_id" {
  description = "Unique id to differentiate multiple terraform configuration states in same namespace"
  type        = string
  default     = "default"
}

variable "docker_image_version" {
  description = "docker image version running kafka connect with bigquery sink connector"
  type        = string
  default     = "latest"
}

variable "zone_letter" {
  description = "GCP default zone letter in suffix. Ex: 'd' in 'europe-west1-d'"
  type        = string
  default     = "d"
}
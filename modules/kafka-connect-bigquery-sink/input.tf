variable "k8s_namespace" {
  description = "helm release k8s namespace"
  type        = string
}

variable "docker_image_version" {
  description = "docker image version running kafka connect with bigquery sink connector"
  type        = string
  default     = "latest"
}

variable "bigquery_project" {
  description = "bigquery project kafka connect biquery sink data is stored in"
  type        = string
}

variable "team" {
  description = "team which deploys kafka connect bigquery sink"
  type        = string
}

variable "team_slack" {
  description = "team slack channel"
  type        = string
}

variable "repo" {
  description = "repo of terraform module"
  type        = string
}

variable "kafka_topics" {
  description = "List of kafka topic names to sink data from"
  type        = list(string)
}

variable "kafka_username" {
  description = "username of kafka consumer user with consumer role on kafka_topics"
  default     = "kcbqsUser"
}

variable "kafka_connect_username" {
  description = "username of kafka connect user with admin role"
  default     = "admin"
}

variable "kafka_connect_workers" {
  description = "number of workers consuming messages from kafka"
  default     = 1
}

variable "kubernetes_secret_name" {
  description = "name of kubernetes secret containing password literals KAFKA_ADMIN_PASSWORD and KAFKA_CONSUMER_PASSWORD"
  default     = "kafka-connect-bigquery-sink-secret-values"
}

variable "kcbqs_pd_key" {
  description = "Pagerduty integration key for Kafka Connect BigQuery Sink Connector"
  type        = string
}

variable "gcp_project" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP default region"
  default     = "europe-west1"
}

variable "cluster_name" {
  description = "GCP cluster name"
  type        = string
}

variable "kafka_bootstrap_servers_map" {
  description = "A map of Kafka Bootstrap servers by k8s namespace"
  type        = map(string)
  default     = {
    dev        = "https://bootstrap.rtd-ext.kafka.entur.io:9095"
    staging    = "https://bootstrap.test-int.kafka.entur.io:9095"
    production = "https://bootstrap.prod-int.kafka.entur.io:9095"
  }
}

variable "kafka_schema_registry_map" {
  description = "A map of Kafka schema registry servers by k8s namespace"
  type        = map(string)
  default     = {
    dev        = "http://schema-registry.rtd-ext.kafka.entur.io:8001"
    staging    = "http://schema-registry.test-int.kafka.entur.io:8001"
    production = "http://schema-registry.prod-int.kafka.entur.io:8001"
  }
}

variable "instance_id" {
  description = "Unique id to differentiate multiple terraform configuration states in same namespace"
  type        = string
  default     = "default"
}

variable "zone_letter" {
  description = "GCP default zone letter in suffix. Ex: 'd' in 'europe-west1-d'"
  type        = string
  default     = "d"
}

locals {
  labels = {
    team        = var.team
    slack       = var.team_slack
    environment = var.k8s_namespace
    namespace   = var.k8s_namespace
    repo        = var.repo
    managed-by  = "terraform"
  }
  name_prefix             = "kcbqs"
  helm_release_name       = "${var.team}-${var.instance_id}"
  application_name        = "${local.name_prefix}-${var.team}-${var.instance_id}"
  bigquery_dataset        = replace("${var.team}-${var.instance_id}-${var.k8s_namespace}_raw", "-", "_")
  kcbqs_docker_image      = "eu.gcr.io/entur-system-1287/kafka-connect-bigquery-sink:${var.docker_image_version}"
  kafka_bootstrap_servers = lookup(var.kafka_bootstrap_servers_map, var.k8s_namespace, "Kafka bootstrap server mapping missing for given namespace")
  kafka_schema_registry   = lookup(var.kafka_schema_registry_map, var.k8s_namespace, "Kafka schema registry server mapping missing for given namespace")
}

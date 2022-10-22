module "kafka_connect_bigquery_sink" {
#  source           = "github.com/entur/terraform/modules/kafka-connect-bigquery-sink"
  source           = "./../../modules/kafka-connect-bigquery-sink"
  gcp_project      = var.gcp_project
  cluster_name     = var.cluster_name
  k8s_namespace    = var.kubernetes_namespace
  bigquery_project = var.bigquery_project
  kafka_topics     = var.kafka_topics
  repo             = var.repo
  team             = var.team
  team_slack       = var.team_slack
  instance_id      = var.instance_id
  kcbqs_pd_key     = var.pd_key
}

resource "kubernetes_config_map" "config_files" {
  metadata {
    name      = "${local.application_name}-config-files"
    namespace = var.k8s_namespace
    labels    = local.labels
  }
  data = {
    "logback.xml"                      = file("${path.module}/config/logback.xml")
    "logging.properties"               = file("${path.module}/config/logging.properties")
    "kafka-connect-bigquery-sink.json" = templatefile(
      "${path.module}/config/kafka-connect-bigquery-sink.json.tftpl",
      {
        kafkaTopics         = join(",", var.kafka_topics),
        kafkaSchemaRegistry = local.kafka_schema_registry
        bigQueryProject     = var.bigquery_project
        bigQueryDataset     = local.bigquery_dataset
      }
    )
  }
}

resource "kubernetes_config_map" "script_files" {
  metadata {
    name      = "${local.application_name}-script-files"
    namespace = var.k8s_namespace
    labels    = local.labels
  }
  data = {
    "kcbqs.sh"  = file("${path.module}/scripts/kcbqs.sh")
  }
}
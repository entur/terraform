resource "google_monitoring_notification_channel" "kcbqs_connector_pd_notification_channel" {
  type    = "pagerduty"
  project = var.gcp_project

  display_name = "stackdriver_KafkaConnectBigQuerySinkConnector"

  sensitive_labels {
    service_key = var.kcbqs_pd_key
  }

  user_labels = local.labels
}

resource "google_logging_metric" "logging_metric_kcbqs_connector_error_count" {
  project     = var.gcp_project
  name        = "${local.helm_release_name}-KafkaConnectBigQuerySinkConnector-workload-error-count"
  filter      = "resource.type=\"k8s_container\" resource.labels.project_id=\"${var.gcp_project}\" resource.labels.namespace_name=\"${var.k8s_namespace}\" resource.labels.container_name=\"kafka-connect-bigquery-sink\" severity>=\"ERROR\""
  description = "Error count for Kafka Connect BigQuery Sink Connector"

  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "alert_policy_kcbqs_connector_workload_errors_greater_than_zero" {
  project      = var.gcp_project
  display_name = "KafkaConnectBigQuerySinkConnector error count"
  depends_on   = [
    google_logging_metric.logging_metric_kcbqs_connector_error_count
  ]
  notification_channels = [
    google_monitoring_notification_channel.kcbqs_connector_pd_notification_channel.id
  ]
  combiner = "OR"
  conditions {
    display_name = "logging/user/kcbqs-connector-workload-errors-greater-than-zero"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.logging_metric_kcbqs_connector_error_count.name}\" AND resource.type=\"k8s_container\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  documentation {
    content   = "Error count from KafkaConnectBigQuerySinkConnector is greater than zero"
    mime_type = "text/markdown"
  }

  user_labels = local.labels
}

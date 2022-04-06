resource "google_service_account" "sa" {
  project      = var.bigquery_project
  account_id   = local.helm_release_name
  display_name = "Service account for the Kafka Connect BigQuery Sink application ${local.application_name}"
}

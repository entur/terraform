resource "google_bigquery_dataset" "dataset" {
  project     = var.bigquery_project
  dataset_id  = local.bigquery_dataset
  description = "This dataset is used by ${local.application_name} for storage of kafka data"
  location    = "EU"
  labels      = local.labels
}

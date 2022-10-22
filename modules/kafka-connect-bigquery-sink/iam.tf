resource "google_project_iam_member" "data_editor" {
  project    = var.bigquery_project
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.sa.email}"
  depends_on = [google_bigquery_dataset.dataset, google_service_account.sa]
}

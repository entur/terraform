resource "google_service_account_key" "key" {
  service_account_id = google_service_account.sa.name
}

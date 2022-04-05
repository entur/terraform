output "helm_release_id" {
  value = helm_release.kafka_connect_bigquery_sink.id
}

output "kubernetes_config_map_config_files_id" {
  value = kubernetes_config_map.config_files.id
}

output "kubernetes_config_map_script_files_id" {
  value = kubernetes_config_map.script_files.id
}

output "kubernetes_secret_secret_files_id" {
  value = kubernetes_secret.secret_files.id
}

output "service_account_id" {
  value = google_service_account.sa.id
}

output "service_account_key_id" {
  value = google_service_account_key.key.id
}

output "bigquery_dataset_id" {
  value = google_bigquery_dataset.dataset.id
}
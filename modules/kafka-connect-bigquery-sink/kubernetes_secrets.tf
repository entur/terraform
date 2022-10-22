resource "kubernetes_secret" "secret_files" {
  metadata {
    name      = "${local.application_name}-secret-files"
    namespace = var.k8s_namespace
    labels    = local.labels
  }
  data = {
    "service-account-credentials.json" = base64decode(google_service_account_key.key.private_key)
  }
}

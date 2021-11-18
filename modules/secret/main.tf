terraform {
  required_version = ">= 0.13"
}
resource "kubernetes_secret" "the-secret" {
  metadata {
    name      = var.secret_name
    namespace = var.kubernetes_namespace
    labels    = var.labels
  }

  data = var.secret_data

  type = "kubernetes.io/basic-auth"
}

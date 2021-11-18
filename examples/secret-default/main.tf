terraform {
  required_version = ">= 0.13"
}

module "my-secret" {
  source               = "github.com/entur/terraform//modules/secret"
  secret_name          = var.secret_name
  kubernetes_namespace = var.kubernetes_namespace
  labels               = var.labels
  secret_data          = var.secret_data
}

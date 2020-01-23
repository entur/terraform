
terraform {
  required_version = ">= 0.12"
}

module "bucket" {
  source                      = "github.com/entur/terraform//modules/bucket"
  labels                      = var.labels
  gcp_project                 = var.gcp_project
  location                    = "europe-west1"
  storage_class               = "REGIONAL"
  kubernetes_namespace        = var.kubernetes_namespace
  service_account_bucket_role = "READER"
}

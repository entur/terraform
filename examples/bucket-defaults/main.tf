
terraform {
  required_version = ">= 0.12"
}

module "bucket" {
  source = "github.com/entur/terraform//modules/bucket"
  #source                      = "../../modules/bucket"
  labels                      = var.labels
  gcp_project                 = var.gcp_project
  location                    = var.location
  kubernetes_namespace        = var.kubernetes_namespace
  storage_class               = "REGIONAL"
  service_account_bucket_role = "READER"
  prevent_destroy             = var.prevent_destroy
}

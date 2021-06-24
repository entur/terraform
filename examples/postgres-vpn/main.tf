terraform {
  required_version = ">= 0.12"
}

module "postgres" {
  #source = "github.com/entur/terraform//modules/postgres"
  source               = "../../modules/postgres"
  gcp_project          = var.gcp_project
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
  db_name              = var.db_name
  db_user              = var.db_user
  region               = var.region
  zoneLetter           = var.zone_letter
  prevent_destroy      = var.prevent_destroy
  require_ssl          = var.require_ssl
  authorized_networks  = var.authorized_networks
}

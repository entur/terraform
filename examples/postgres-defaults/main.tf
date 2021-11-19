terraform {
  required_version = ">= 0.13"
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
  zoneLetter           = "d"
  prevent_destroy      = var.prevent_destroy
}

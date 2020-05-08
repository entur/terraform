terraform {
  required_version = ">= 0.12"
}
module "postgres" {
  source                       = "github.com/entur/terraform//modules/ibm-database"
  db_instance_name             = var.db_instance_name
  db_type                      = var.db_type
  kubernetes_namespace         = var.kubernetes_namespace
  labels                       = var.labels
  db_version                   = var.db_version
}

provider "kubernetes" {
  load_config_file = var.load_config_file
}

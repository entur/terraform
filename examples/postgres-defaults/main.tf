terraform {
  required_version = ">= 0.12"
}

module "postgres" {
  source               = "bitbucket.org/enturas/terraform-modules//modules/postgres"
  gco_project          = var.gco_project
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
  postgres_db_name     = "example"
  postgres_user        = "example-user"
  region               = "europe-west1"
  zoneLetter           = "d"
}

terraform {
  required_version = ">= 0.12"
}

module "postgres" {
  # source = "github.com/entur/terraform//modules/postgres"
  source               = "../../modules/postgres"
  gcp_project          = var.gcp_project
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
  db_name              = "example"
  db_user              = "example-user"
  region               = "europe-west1"
  zoneLetter           = "d"
  prevent_destroy      = var.prevent_destroy
}

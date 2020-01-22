terraform {
  required_version = ">= 0.12"
}

locals {
  env = split("-", terraform.workspace)[0]
}

resource "google_service_account" "team-instance-credentials" {
  account_id   = "${var.labels.app}-${var.kubernetes_namespace}-cred"
  display_name = "Service Account for ${var.labels.team} team SQL"
}

resource "google_service_account_key" "team-instance-credentials" {
  service_account_id = google_service_account.team-instance-credentials.name
}

resource "google_project_iam_member" "project" {
  project = var.gcp_project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.team-instance-credentials.email}"
}

//https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/2.0.0/submodules/postgresql
module "sql-db_postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "2.0.0"
  # insert the 4 required variables here
  database_version = var.postgresql_version
  name             = "${var.labels.team}-${var.labels.app}-${var.kubernetes_namespace}-${var.db_instance_suffix}" //postgresql-${random_id.name.hex}"
  project_id       = var.gcp_project
  region           = var.region
  zone             = var.zoneLetter
  user_labels      = var.labels
  db_name          = var.db_name

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    authorized_networks = []
  }

  user_name = var.db_user

  backup_configuration = {
    enabled            = var.db_instance_backup_enabled
    start_time         = var.db_instance_backup_time
    binary_log_enabled = false #cannot be used with postgres
  }
}


resource "kubernetes_secret" "team-db-credentials" {
  depends_on = [
    module.sql-db_postgresql
  ]
  metadata {
    name      = "${var.labels.app}-db-credentials"
    namespace = var.kubernetes_namespace
    labels    = var.labels
  }
  data = {
    username = var.db_user
    password = module.sql-db_postgresql.generated_user_password
  }
}

resource "kubernetes_secret" "team-instance-credentials" {
  metadata {
    name      = "${var.labels.app}-instance-credentials"
    namespace = var.kubernetes_namespace
    labels    = var.labels
  }
  data = {
    "credentials.json" = "${base64decode(google_service_account_key.team-instance-credentials.private_key)}"
  }
}

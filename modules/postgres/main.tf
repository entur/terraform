terraform {
  required_version = ">= 0.12"
}

locals {
  env = split("-", terraform.workspace)[0]
}

provider "google" {
  project = var.gcp_project
  region  = var.region
  zone    = "${var.region}-${var.zoneLetter}"
}

provider "google-beta" {
  project = var.gcp_project
  region  = var.region
  zone    = "${var.region}-${var.zoneLetter}"
}

resource "google_service_account" "team-instance-credentials" {
  count = var.account_id_use_existing == true ? 0 : 1
  account_id   = length(var.account_id) > 0 ? var.account_id : "${var.labels.app}-${var.kubernetes_namespace}-cred"
  display_name   = length(var.account_id) > 0 ? var.account_id : "${var.labels.app}-${var.kubernetes_namespace}-cred"
  description = "Service Account for ${var.labels.app} SQL"
  project = var.gcp_project
}

resource "google_service_account_key" "team-instance-credentials" {
  service_account_id = var.account_id_use_existing == true ? var.account_id : google_service_account.team-instance-credentials[0].name
}

resource "google_project_iam_member" "project" {
  count = var.account_id_use_existing == true ? 0 : 1
  project = var.gcp_project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.team-instance-credentials[0].email}"
}

//https://registry.terraform.io/modules/GoogleCloudPlatform/sql-db/google/2.0.0/submodules/postgresql
module "sql-db_postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "2.0.0"

  database_version  = var.postgresql_version
  name              = length(var.db_instance_custom_name) > 0 ? var.db_instance_custom_name : "${var.labels.app}-${var.kubernetes_namespace}-${random_id.suffix.hex}"
  project_id        = var.gcp_project
  region            = var.region
  zone              = var.zoneLetter
  user_labels       = var.labels
  db_name           = var.db_name
  tier              = var.db_instance_tier
  disk_size         = var.db_instance_disk_size
  availability_type = var.availability_type


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
  create_timeout = var.create_timeout
  delete_timeout = var.delete_timeout
  update_timeout = var.update_timeout
}

resource "random_id" "protector" {
  count       = var.prevent_destroy ? 1 : 0
  byte_length = 8
  keepers = {
    protector = module.sql-db_postgresql.instance_name
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "random_id" "suffix" {
  byte_length = 2
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
    "credentials.json" = base64decode(google_service_account_key.team-instance-credentials.private_key)
    INSTANCES          = "${module.sql-db_postgresql.instance_connection_name}=tcp:5432"
  }
}

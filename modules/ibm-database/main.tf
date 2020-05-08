terraform {
  required_version = ">= 0.12"
}

provider "ibm" {
  region = var.region
}

data "ibm_resource_group" "default" {
  name = "Default"
}

locals {
  tags = [for key, value in var.labels : "${key}:${value}"]
}

resource "random_password" "db_password" {
  length  = 12
  special = false
}

resource "ibm_database" "db" {
  name              = var.db_instance_name
  plan              = var.db_instance_plan
  location          = var.region
  service           = var.db_type
  version           = var.db_version
  resource_group_id = data.ibm_resource_group.default.id
  tags              = local.tags

  members_memory_allocation_mb = var.db_instance_memory_mb
  members_disk_allocation_mb   = var.db_instance_disk_size_mb
  users {
    name     = var.application_db_user
    password = random_password.db_password.result
  }
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

resource "kubernetes_secret" "team-db-credentials" {
  metadata {
    name      = "${var.labels.app}-db-credentials"
    namespace = var.kubernetes_namespace
    labels    = var.labels
  }
  data = {
    args     = ibm_database.db.connectionstrings.0.queryoptions
    cert     = base64decode(ibm_database.db.connectionstrings.0.certbase64)
    host     = ibm_database.db.connectionstrings.0.hosts.0.hostname
    name     = ibm_database.db.connectionstrings.0.database
    port     = ibm_database.db.connectionstrings.0.hosts.0.port
    username = var.application_db_user
    password = random_password.db_password.result
  }
}

resource "random_id" "protector" {
  count       = var.prevent_destroy ? 1 : 0
  byte_length = 8
  keepers = {
    protector = ibm_database.db.name
  }
  lifecycle {
    prevent_destroy = true
  }
}


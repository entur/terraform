terraform {
  required_version = ">= 0.12"
}

locals {
  prefix               = var.branch_environment ? "env-" : ""
  kubernetes_namespace = "${local.prefix}${var.kubernetes_namespace}"
  ns_labels = {
    timestamp          = var.branch_environment ? timestamp() : ""
    branch_environment = var.branch_environment
  }
}

resource "kubernetes_namespace" "environment" {
  metadata {
    annotations = {
      name = local.kubernetes_namespace
    }
    labels = merge(var.labels, local.ns_labels)
    name   = local.kubernetes_namespace
  }
}

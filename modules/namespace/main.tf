terraform {
  required_version = ">= 0.12"
}

locals {
  prefix                = var.branch_environment ? "env-" : ""
  kubernetes_namespace  = "${local.prefix}${var.kubernetes_namespace}"
  ns_labels = {
    timestamp           = timestamp()
    branch_environment  = var.branch_environment
  }
}

resource "kubernetes_namespace" "environment" {
  # do not try to re-create existing namespaces
  count = contains(var.reserved_namespaces, var.kubernetes_namespace) ? 0 : 1
  metadata {
    annotations = {
      name = local.kubernetes_namespace
    }
    labels = merge(var.labels, local.ns_labels)
    name   = local.kubernetes_namespace
  }
}
terraform {
  required_version = ">= 0.12"
}

locals {
  kubernetes_namespace = var.kubernetes_namespace == "master" ? var.master_override : var.kubernetes_namespace
  
  ns_labels = {
    timestamp = timestamp()
  }
}

resource "kubernetes_namespace" "environment" {
  # do not try to re-create 'default' namespace
  count = contains(var.reserved_namespaces, local.kubernetes_namespace) ? 0 : 1
  metadata {
    annotations = {
      name = local.kubernetes_namespace
    }
    labels = merge(var.labels, local.ns_labels)
    name   = local.kubernetes_namespace
  }
}

terraform {
  required_version = ">= 0.13.2"
}

# Creates env-demo-ns where the requested kubernetes_namespace is demo-ns
# We enforce env- prefix to avoid pollution of k8s namespaces
module "namespace" {
  source = "github.com/entur/terraform//modules/namespace"
  #source               = "../../modules/namespace"
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
}

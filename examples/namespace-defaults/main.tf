
terraform {
  required_version = ">= 0.13.2"
}

# This will end up not creating a namespace
# because we target master branch
module "namespace" {
  source = "github.com/entur/terraform//modules/namespace"
  #source               = "../../modules/namespace"
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
}

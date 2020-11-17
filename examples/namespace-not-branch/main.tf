
terraform {
  required_version = ">= 0.13.2"
}

# This will create a team based environment that is not a short lived branch environment
# Useful for a team specific dev environment as an example
module "namespace" {
  source = "github.com/entur/terraform//modules/namespace"
  #source               = "../../modules/namespace"
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
  branch_environment   = false
}

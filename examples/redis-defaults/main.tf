terraform {
  required_version = ">= 0.12"
}

module "redis" {
  source = "github.com/entur/terraform//modules/redis"
  #source               = "../../modules/redis"
  gcp_project          = var.gcp_project
  labels               = var.labels
  kubernetes_namespace = var.kubernetes_namespace
  zone                 = "europe-west1-d"
  reserved_ip_range    = var.redis_reserved_ip_range
  prevent_destroy      = var.prevent_destroy
}

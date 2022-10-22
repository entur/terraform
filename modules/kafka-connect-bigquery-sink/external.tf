data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  name     = var.cluster_name
  location = var.region
  project  = var.gcp_project
}

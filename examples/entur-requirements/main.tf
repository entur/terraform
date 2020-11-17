terraform {
  required_version = ">= 0.13.2"
}

provider "kubernetes" {
  load_config_file = var.load_config_file
}

module "entur" {
  source = "github.com/entur/terraform//modules/entur"
  # source = "../../modules/entur"
  labels = var.labels
}
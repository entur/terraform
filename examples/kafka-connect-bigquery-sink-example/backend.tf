terraform {
  backend "gcs" {
    bucket = "entur-team-data-tf"
    prefix = "gcp/kafka-connect-bigquery-sink-data"
  }
}
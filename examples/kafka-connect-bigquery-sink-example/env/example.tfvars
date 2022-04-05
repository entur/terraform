gcp_project          = "entur-test-1287"
cluster_name         = "entur-test"
kubernetes_namespace = "staging"
bigquery_project     = "entur-analytics-rtd"
kafka_topics         = ["seating-railcar-group-info-diff-v0-staging", "seating-reservations-diff-v0-staging", "seating-seat-capacity-diff-v0-staging", "seating-total-capacity-diff-v0-staging"]
repo                 = "kafka-connect-bigquery-data"
team                 = "data"
team_slack           = "talk-data"
# Use instance_id to deploy multiple instances of Kafka sink connector configurations in same namespace
instance_id          = "to-be-deleted"

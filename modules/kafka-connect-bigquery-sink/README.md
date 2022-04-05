# Kafka Sink Connector - BigQuery module

This module provides the Terraform infrastructure to deploy a Kafka Connect job that consumes data from Kafka specified topics and writes to BigQuery tables.

## Deploying a sink connector
Kafka sink connector for BigQuery is driven by the configuration managed by terraform module as listed in terraform directory.

Most of the parameters are fixed but there are few specific to a given team to be configured as described in 'How to deploy?' section below

Refer to the [example folder](../../examples/kafka-connect-bigquery-sink-example) for a quick reference to set up multiple instances Kafka sink connectors ina given kubernetes environment.

Example use of module:
```terraform
module "kafka_connect_bigquery_sink" {
   source           = "github.com/entur/terraform//modules/kafka-connect-bigquery-sink"
   gcp_project      = var.gcp_project
   cluster_name     = var.cluster_name
   k8s_namespace    = var.kubernetes_namespace
   bigquery_project = var.bigquery_project
   kafka_topics     = var.kafka_topics
   repo             = var.repo
   team             = var.team
   team_slack       = var.team_slack
   instance_id      = var.instance_id
   kcbqs_pd_key     = var.pd_key
}
```
### Prerequisites
1. Create a PageDuty service to monitor alerts for Kafka Sink Connector logs. Refer to an example [here](https://enturas.pagerduty.com/service-directory/PSGFFU8)
2. Provide the PagerDuty integration key when asked for during terraform apply

### How to deploy?
1. Use correct gcs bucket for your team in [backend.tf](../../examples/kafka-connect-bigquery-sink-example/backend.tf)
2. Configure input to Kafka Connect BigQuery Sink terraform module in [main.tf](../../examples/kafka-connect-bigquery-sink-example/main.tf)
    1. Provide values for `gcp_project, cluster_name, k8s_namespace` based on where you want to deploy your sink connector
    2. Provide a BigQuery data project for your team at `bigquery_project`. Follow the naming convention `entur-<team-name>-raw` for ingesting raw data from Kafka queues.
    3. Provide your team name at `team` and your teams slack channel name at `team_slack` for annotation purpose on various resources being created from this module
    4. Provide a list of topics to be read from at `kafka_topics`. Ex:- `["topic-1", "topic-2"]`
    5. Create pager duty service for your team according to [monitoring.tf](monitoring.tf) file and provide the integration key at `kcbqs_pd_key`
3. In order to deploy one or more instances of kafka sink connector for BigQuery in dev/staging/production environments
    1. Run `terraform init` first
    2. Run `terraform workspace list` to list all available workspaces
    3. Run `terraform workspace new dev` to create `dev` workspace or run `terraform workspace select dev` to select `dev` workspace if it already exists
    4. Run `terraform plan -var-file=env/dev.tfvars -out dev.out` to generate plan for deployment in `dev` environment
    5. Run `terraform apply dev.out` to perform the deployment
    6. Replace `dev` with `staging/production` to deploy in respective environments
    7. In order to deploy multiple instances of kafka sink connector in same namespace use a different instance_id for each deployment configuration
    8. Run `terraform destroy -var-file=env/dev.tfvars` to remove all the resources created from terraform state

### How to run?
After helm chart is deployed to k8s, Sink Connector starts automatically with the specified configuration enabled.

### Troubleshooting
1. ssh into sink connector pod by running `kubectl -n dev exec --tty --stdin <pod> -- /bin/bash` to interact with Kafka Connect as it's REST API is not public
2. Go to scripts directory `cd /etc/kafka-connect-bigquery-sink/scripts/`
3. Run `./kcbqs.sh --status` to check the status of connector
4. Run `./kcbqs.sh --start` to start and `./kcbqs.sh --stop` to stop the sink connector

### How to add/remove topics to the sink connector
1. Update the `kafka_topics` input variable with new list of topics
2. Replace and restart the helm release state to reload the updated configuration by running the command `terraform apply --var-file=env/dev.tfvars -replace="module.kafka_connect_bigquery_sink.helm_release.kafka_connect_bigquery_sink"`


## References
1. Confluents [Google BigQuery Sink Connector](https://docs.confluent.io/kafka-connect-bigquery/current/overview.html) and its [configuration](https://docs.confluent.io/kafka-connect-bigquery/current/kafka_connect_bigquery_config.html)
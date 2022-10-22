resource "helm_release" "kafka_connect_bigquery_sink" {
  name      = local.helm_release_name
  chart     = "${path.module}/helm"
  namespace = var.k8s_namespace

  lint          = true
  atomic        = true
  recreate_pods = true

  values = [file("${path.module}/helm/values.yaml")]

  depends_on = [kubernetes_config_map.config_files, kubernetes_config_map.script_files, kubernetes_secret.secret_files]

  set {
    name  = "container.name"
    value = local.application_name
  }

  set {
    name  = "nameOverride"
    value = local.name_prefix
  }

  set {
    name  = "image"
    value = local.kcbqs_docker_image
  }

#  set {
#    name  = "timeout"
#    value = "120"
#  }

  set {
    name  = "secrets.secretFiles"
    value = kubernetes_secret.secret_files.metadata[0].name
  }

  set {
    name  = "secrets.secretValues"
    value = var.kubernetes_secret_name
  }

  set {
    name  = "config.configFiles"
    value = kubernetes_config_map.config_files.metadata[0].name
  }

  set {
    name  = "scripts.scriptFiles"
    value = kubernetes_config_map.script_files.metadata[0].name
  }

  set {
    name  = "replicaCount"
    value = var.kafka_connect_workers
  }

  set {
    name  = "connect.bootstrapServers"
    value = local.kafka_bootstrap_servers
  }

  set {
    name  = "connect.valueConverterSchemaRegistryUrl"
    value = local.kafka_schema_registry
  }

  set {
    name  = "kafka.admin.username"
    value = var.kafka_connect_username
  }

  set {
    name  = "kafka.consumer.username"
    value = var.kafka_username
  }

  set {
    name  = "connect.configStorageTopic"
    value = "${local.application_name}-config-storage"
  }

  set {
    name  = "connect.offsetStorageTopic"
    value = "${local.application_name}-offset-storage"
  }

  set {
    name  = "connect.statusStorageTopic"
    value = "${local.application_name}-status-storage"
  }

  set {
    name  = "connect.groupId"
    value = local.application_name
  }

  set {
    name  = "connect.consumer.groupId"
    value = "${local.application_name}-consumer"
  }
}

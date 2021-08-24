# Redis module

This module can be used to quickly get a redis up and running according to Entur conventions

## Main effect

- `${var.labels.app}-${var.kubernetes_namespace}-${random_id.suffix.hex}`.
  - `[app]-[namespace]-[randomsuffix]`
  - Name of the Redis instance
  - Render: `awesomeblog-production-aa4c`
    - app = `awesomeblog`
    - namespace = `production`

## Side effects

Generated Kubernetes Config Map:

- `${var.labels.app}-redis-configmap` with `{ REDIS_HOST: "host of redis" }`
  - `[app]-redis-configmap`
  - Name of the Redis instance
  - Render: `awesomeblog-redis-configmap`
    - app = `awesomeblog`

## Inputs

| Name                             | Description                                                                                                                                                     |  Type  |  Default  | Required |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-------: | :------: |
| gcp_project                      | The name of your GCP project                                                                                                                                    | string |    n/a    |   yes    |
| zone                             | The name of your default zone                                                                                                                                   | string |    n/a    |   yes    |
| labels                           | The labels you wish to decorate with                                                                                                                            | string |    n/a    |   yes    |
| labels.team                      | The name of your team or department                                                                                                                             | string |    n/a    |   yes    |
| labels.app                       | The name of this appliation / workload                                                                                                                          | string |    n/a    |   yes    |
| reserved_ip_range                | The reserved IP range in CIDR notation                                                                                                                          | string |    n/a    |   yes    |
| kubernetes_namespace             | The namespace you wish to target. Note, this is only here to allow separate envs to have different redis instances. They do not actually live in the namespace. | string |    n/a    |   yes    |
| prevent_destroy                  | Prevents the destruction of the bucket                                                                                                                          |  bool  |   false   |    no    |
| redis_instance_custom_name       | Redis instance name override                                                                                                                                    | string |    n/a    |    no    |
| enable_apis                      | Flag for enabling redis API in your project                                                                                                                     |  bool  |   false   |    no    |
| authorized_network_name_override | Redis instance authorized network name override                                                                                                                 | string |    n/a    |    no    |
| redis_config                     | Configuration parameters passed to the redis instance on creation in Google Cloud                                                                               |  map   | see below |    no    |

### Redis settings

Redis settings are passed to Google through key/values in the `redis_config` map.
The default values are as follows, and should be overridden if necessary:

```
maxmemory_policy = allkeys-lfu
activedefrag = yes
```

More information about these settings are found [in Googles documentation](https://cloud.google.com/memorystore/docs/redis/redis-configs)
Additional parameters can be added as necessary, but remember to check Googles documentation to see if the variables are supported.

## Outputs

| Name | Description |
| ---- | ----------- |
| none | n/a         |

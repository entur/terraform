# Modules

This repository is in active development. Feel free to contribute!

## [Postgres](./modules/postgres)

```hcl
module "postgres" {
  source               = "github.com/entur/terraform//modules/postgres"
  gcp_project          = "your-gcp-project"
  labels               = {
    team = "myteam"
    app  = "mypp"
  }
  kubernetes_namespace = "default"
  db_name              = "example"
  db_user              = "example-user"
  region               = "europe-west1"
  zoneLetter           = "d"
}
```
    
## [Redis](./modules/redis)

```hcl
module "redis" {
  source               = "github.com/entur/terraform//modules/redis"
  gcp_project          = "your-project"
  labels               = {
    team = "myteam"
    app  = "mypp"
  }
  kubernetes_namespace = "default"
  zone                 = "europe-west1-d"
  reserved_ip_range    = "10.100.10.8/29"
}
```

## [Bucket](./modules/bucket)

```hcl
module "bucket" {
  source                      = "github.com/entur/terraform//modules/bucket"
  labels                      = {}
  gcp_project                 = "your-project"
  location                    = "europe-west1"
  storage_class               = "REGIONAL"
  kubernetes_namespace        = "default"
  service_account_bucket_role = "READER"
}
```

## [Secret](./modules/secret)

```hcl
module "my-secret" {
  source               = "github.com/entur/terraform//modules/secret"
  secret_name          = var.secret_name
  kubernetes_namespace = var.kubernetes_namespace
  labels               = var.labels
  secret_data          = var.secret_data
}
```

# Contribute

Feel free to add a module and provide a PR.
Follow the same conventions as seen in `/modules` and `/examples`.
For testing a module, create a `variables.auto.tfvars` in the example directory (this is ignored by git) so you don't have to fill inn all variables all the time.

Please try to keep away from using default vaules that are not default for most users (also outside Entur).
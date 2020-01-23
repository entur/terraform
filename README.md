# Work in progress

This repository is in active development. Feel free to contribute!

## [Postgres](./modules/postgres)

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
    
## [Redis](./modules/redis)

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

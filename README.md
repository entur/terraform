<span style="color:red;font-size:18pt">:warning: *These modules are deprecated.*</span><br>
Next generation modules can be found here:<br>
https://github.com/search?q=topic%3Aterraform-modules+-topic%3Adeprecated+org%3Aentur&type=Repositories

# Terraform Modules [![CircleCI](https://circleci.com/gh/entur/terraform.svg?style=svg)](https://circleci.com/gh/entur/terraform)

Team Plattform provides a set of Terraform Modules that will help you write a conformant and concise Terraform configuration for your applications!

## Handle module versions
If you want to control the version of your module dependency you can add `?ref=TAG` at the end of the `source` parameter for the modules. 

Locate a [release](https://github.com/entur/terraform/releases) and update `source` like f.ex:

```hcl
module "postgres" {
  source               = "github.com/entur/terraform//modules/postgres?ref=v0.0.27"
}
```

Have fun terraforming!

# Available Modules for Google Cloud Platform

## [Bucket](./modules/bucket)

## [Entur](./modules/entur)

## [Postgres](./modules/postgres)
    
## [Redis](./modules/redis)

## [Secret](./modules/secret)

## [Kafka Sink Connector for BigQuery](./modules/kafka-connect-bigquery-sink)

# Available Modules for IBM Cloud

## [IBM Database](./modules/ibm-database)

# Contribute

This repository is automatically built (it will tag your commit with `$NEXT_VERSION-rc$YOURBUILDNUM`) for brances, and increment patch from master.

Feel free to add a module and provide a PR.
Follow the same conventions as seen in `/modules` and `/examples`.
For testing a module, create a `variables.auto.tfvars` in the example directory (this is ignored by git) so you don't have to fill inn all variables all the time.

Please try to keep away from using default vaules that are not default for most users (also outside Entur).

## Handle errors and precondition

Sometimes it may be a good idea to supply some conditions and checks. This is how to do it:

```hcl
resource "null_resource" "name_of_condition" {
  count = CONDITION ? 1 : "Error message here"
}
```

variable "project" {}
variable "region" {}
variable labels {}

variable "runtime" {
    description = "type of runtimes java|python|nodejs.... (see documentation for correct value)"
}
variable run_memmory {
    default=128
}

variable timeout {
    default=120
}

variable "function_name" {}
variable "function_entry_point" {}
variable "function_source" {}

variable "environment_variables" {
  description = "Labels used in all resources"
  type        = map(string)
  default = {
  }
}

variable "project" {}
variable "region" {}

variable "runtime" {
    description = "type of runtimes java|python|nodejs.... (see documentation for correct value)"
}
variable "function_name" {}
variable "function_entry_point" {}
variable "function_source" {}
variable "event_topic" {
  description = "pubsub trigger topic"
  default     = ""
}


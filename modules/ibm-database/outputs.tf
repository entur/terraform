output "db-generated-application-password" {
  value = random_password.db_password.result
}

output "db-host_name" {
  value = ibm_database.db.connectionstrings.0.hosts.0.hostname
}

output "db-host_name2" {
  value = var.db_type == "databases-for-mongodb" ? ibm_database.db.connectionstrings.0.hosts.1.hostname : "no_hostname"
}
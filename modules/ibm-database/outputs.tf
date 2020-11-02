output "db-generated-application-password" {
  value = random_password.db_password.result
}

output "db-host_name" {
  value = ibm_database.db.connectionstrings.0.hosts.0.hostname
}

output "db-host_name2" {
  value = length(ibm_database.db.connectionstrings.0.hosts) >= 2 ? ibm_database.db.connectionstrings.0.hosts.1.hostname : ""
}

output "db-host_name3" {
  value = length(ibm_database.db.connectionstrings.0.hosts) >= 3 ? ibm_database.db.connectionstrings.0.hosts.2.hostname : ""
}
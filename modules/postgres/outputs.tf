output "sql-db-generated-user-password" {
  value = module.sql-db_postgresql.generated_user_password
}

output "sql-db-instance_name" {
  value = module.sql-db_postgresql.instance_name
}

output "sql-db-instance_connection_name" {
  value = module.sql-db_postgresql.instance_connection_name
}

output "sql-db-instance_self_link" {
  value = module.sql-db_postgresql.instance_self_link
}
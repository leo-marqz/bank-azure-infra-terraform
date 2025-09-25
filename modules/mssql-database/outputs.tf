

output "server_name" {
  description = "The name of the MSSQL server."
  value       = azurerm_mssql_server.server.name
}

output "database_name" {
  description = "The name of the MSSQL database."
  value       = azurerm_mssql_database.database.name
}

output "connection_string" {
  description = "The connection string for the MSSQL database."
  value       = azurerm_mssql_server.server.fully_qualified_domain_name
}



# Este módulo exporta la información de la base de datos de CosmosDB.

output "account_name" {
  description = "The name of the CosmosDB account."
  value       = azurerm_cosmosdb_account.account.name
}

output "database_name" {
  description = "The name of the CosmosDB SQL Database."
  value       = azurerm_cosmosdb_sql_database.database.name
}

output "connection_string" {
  description = "The connection string for the CosmosDB account."
  value       = azurerm_cosmosdb_account.account.primary_sql_connection_string
  sensitive   = true
}



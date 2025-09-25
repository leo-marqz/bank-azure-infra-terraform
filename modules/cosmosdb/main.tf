
# Este módulo crea una cuenta de CosmosDB y una base de datos SQL asociada.

resource "azurerm_cosmosdb_account" "account" {
  name                = "cosmosdb-account-${var.name}-${var.location_slug}"
  resource_group_name = var.resource_group_name
  location            = var.location
  offer_type          = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = var.location
    failover_priority = 0
  }
  tags                = var.tags
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = "cosmosdb-sql-${var.name}-${var.location_slug}"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.account.name
}

# ------------------------------------
# Contenedor de CosmosDB (Collection)
# ------------------------------------
resource "azurerm_cosmosdb_sql_container" "notification_container" {
  name                  = "Notification"
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.account.name
  database_name         = azurerm_cosmosdb_sql_database.database.name
  partition_key_paths    = ["/correlationId"]
  partition_key_version = 1
  throughput            = 400
}

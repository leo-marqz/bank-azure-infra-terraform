
# Este módulo crea un servidor de MSSQL y una base de datos asociada.

resource "azurerm_mssql_server" "server" {
  name                         = "sql-server-${var.name}-${var.location_slug}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  tags                         = var.tags
}

resource "azurerm_mssql_database" "database" {
  name      = "mssql-database-${var.name}-${var.location_slug}"
  server_id = azurerm_mssql_server.server.id
  sku_name  = var.sku_name
  tags      = var.tags
}

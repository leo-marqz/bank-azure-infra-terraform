
# Este módulo crea un recurso de Azure Key Vault para la gestión de secretos.
resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
}

# Usa este data source para obtener la configuración del proveedor AzureRM.
data "azurerm_client_config" "current" {}

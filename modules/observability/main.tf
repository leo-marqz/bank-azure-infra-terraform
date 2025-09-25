
# Este módulo crea un recurso de Azure Application Insights para la telemetría.

# # =======================
# # Azure App Insights
# # =======================
resource "azurerm_application_insights" "app_insights" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  tags                = var.tags
}

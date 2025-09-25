
# Este módulo crea la infraestructura para una Azure Function de tipo Dead-Letter.

# ------------------------------------
# Azure Storage Account
# La Function App necesita una cuenta de almacenamiento para funcionar.
# ------------------------------------
resource "azurerm_storage_account" "storage_account" {
  name                     = "stacfunc${var.location}${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

# La cuenta de almacenamiento necesita un nombre globalmente único, por lo que le agregamos un sufijo.
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
  numeric = true
}

# ------------------------------------
# App Service Plan para la Function
# ------------------------------------
resource "azurerm_service_plan" "app_service_plan" {
  name                = "app-service-plan-${var.name}-${var.location_slug}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1" # Plan de consumo para Azure Functions
  tags                = var.tags
}

# ------------------------------------
# Azure Function App
# ------------------------------------
resource "azurerm_linux_function_app" "function_app" {
  name                       = "function-${var.name}-${var.location_slug}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.app_service_plan.id
  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  site_config {
    always_on = false
  }
  tags = var.tags
}

terraform {
    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "4.42.0"
        }
    }
}

provider "azurerm" {
  # Configuration options
  features {
    resource_group {
        prevent_deletion_if_contains_resources = false
    }
  }
}
//
resource "azurerm_resource_group" "rg_bank_microservices" {
  name = "rg-transfer-microservices-${var.azure_location_slug}"
  location = var.azure_location
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Microservice -> API Gateway
# =========================================================================================
resource "azurerm_service_plan" "app_service_plan_apigateway" {
  name = "app-service-plan-apigateway-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = var.app_service_plan_sku
  tags = var.bank_microservices_tags
}

resource "azurerm_linux_web_app" "app_service_apigateway" {
  name = "app-service-apigateway-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_apigateway.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Microservice -> Transaction
# =========================================================================================
resource "azurerm_service_plan" "app_service_plan_transaction" {
  name = "app-service-plan-transaction-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = var.app_service_plan_sku
  tags = var.bank_microservices_tags
}

resource "azurerm_linux_web_app" "app_service_transaction" {
  name = "app-service-transaction-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_transaction.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
  tags = var.bank_microservices_tags
}


# =========================================================================================
# Microservice -> Balance
# =========================================================================================
resource "azurerm_service_plan" "app_service_plan_balance" {
  name = "app-service-plan-balance-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = var.app_service_plan_sku
  tags = var.bank_microservices_tags
}

resource "azurerm_linux_web_app" "app_service_balance" {
  name = "app-service-balance-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_balance.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
  tags = var.bank_microservices_tags
}


# =========================================================================================
# Microservice -> Transfer
# =========================================================================================
resource "azurerm_service_plan" "app_service_plan_transfer" {
  name = "app-service-plan-transfer-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = var.app_service_plan_sku
  tags = var.bank_microservices_tags
}

resource "azurerm_linux_web_app" "app_service_transfer" {
  name = "app-service-transfer-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_transfer.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Microservice -> Notification
# =========================================================================================
resource "azurerm_service_plan" "app_service_plan_notification" {
  name = "app-service-plan-notification-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = var.app_service_plan_sku
  tags = var.bank_microservices_tags
}

resource "azurerm_linux_web_app" "app_service_notification" {
  name = "app-service-notification-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_notification.id
  site_config {
    always_on = false
    application_stack {
      docker_image_name = "nginx:latest"
    }
  }
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Database -> Microservice -> Transaction (Microsoft SQL Server)
# =========================================================================================
resource "azurerm_mssql_server" "mssql_server_transaction" {
  name = "sql-server-transaction-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  version = "12.0"
  administrator_login = var.tmp_username
  administrator_login_password = var.tmp_password
  tags = var.bank_microservices_tags
}

resource "azurerm_mssql_database" "mssql_database_transaction" {
  name = "mssql-database-transaction-${var.azure_location_slug}"
  server_id = azurerm_mssql_server.mssql_server_transaction.id
  sku_name = var.mssql_server_sku
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Database -> Microservice -> Balance (Microsoft SQL Server)
# =========================================================================================
resource "azurerm_mssql_server" "mssql_server_balance" {
  name = "sql-server-balance-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  version = "12.0"
  administrator_login = var.tmp_username
  administrator_login_password = var.tmp_password
  tags = var.bank_microservices_tags
}

resource "azurerm_mssql_database" "mssql_database_balance" {
  name = "mssql-database-balance-${var.azure_location_slug}"
  server_id = azurerm_mssql_server.mssql_server_balance.id
  sku_name = var.mssql_server_sku
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Database -> Microservice -> Transfer (Microsoft SQL Server)
# =========================================================================================
resource "azurerm_mssql_server" "mssql_server_transfer" {
  name = "sql-server-transfer-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  version = "12.0"
  administrator_login = var.tmp_username
  administrator_login_password = var.tmp_password
  tags = var.bank_microservices_tags
}

resource "azurerm_mssql_database" "mssql_database_transfer" {
  name = "mssql-database-transfer-${var.azure_location_slug}"
  server_id = azurerm_mssql_server.mssql_server_transfer.id
  sku_name = var.mssql_server_sku
  tags = var.bank_microservices_tags
}

# =========================================================================================
# Database -> Microservice -> Notification (Azure CosmosDB)
# =========================================================================================
resource "azurerm_cosmosdb_account" "cosmosdb_account_notification" {
  name = "cosmosdb-account-notification-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  offer_type = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location = var.azure_location
    failover_priority = 0 
  }
  tags = var.bank_microservices_tags
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_notification" {
  name = "cosmosdb-sql-notification-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  account_name = azurerm_cosmosdb_account.cosmosdb_account_notification.name
}

# ================================================================================================
# Storage Account (Azure Storage Account) -> Microservice -> Function Dead Letter (Azure Function)
# ================================================================================================
resource "azurerm_storage_account" "storage_account_function_dead_letter" {
  name = "stacfunc${var.azure_location}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  account_tier = "Standard"
  account_replication_type = "LRS"
  tags = var.bank_microservices_tags
}

# ================================================================================================
# Function -> Microservice -> Function Dead Letter (Azure Function)
# ================================================================================================
# App Service Plan
resource "azurerm_service_plan" "app_service_plan_function_dead_letter" {
  name = "app-service-plan-function-dead-letter-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  os_type = "Linux"
  sku_name = "Y1"
  tags = var.bank_microservices_tags
}

# Azure Function
resource "azurerm_linux_function_app" "function_app_dead_letter" {
  name = "function-dead-letter-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  service_plan_id = azurerm_service_plan.app_service_plan_function_dead_letter.id
  storage_account_name = azurerm_storage_account.storage_account_function_dead_letter.name
  storage_account_access_key = azurerm_storage_account.storage_account_function_dead_letter.primary_access_key
  site_config {
    always_on = false
  }
  tags = var.bank_microservices_tags
}

# =======================
# Azure Service Bus
# =======================
resource "azurerm_servicebus_namespace" "service_bus_transfer_app" {
  name = "service-bus-transfer-app-${var.azure_location_slug}"
  location = var.azure_location
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  sku = "Standard" #Basic, Premium, para este caso por los topics solo nos sirve Standard y Premium
  tags = var.bank_microservices_tags
}

# =======================
# Azure App Insights
# =======================
resource "azurerm_application_insights" "application_insights_transfer_app" {
  name = "application-insights-transfer-app-${var.azure_location_slug}"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  application_type = "web"
  tags = var.bank_microservices_tags
}

# =======================
# Azure Key Vault
# =======================
resource "azurerm_key_vault" "key_vault_transfer_app" {
  name = "key-vault-transfer-app"
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  location = var.azure_location
  sku_name = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
  tags = var.bank_microservices_tags
}

# Use this data source to access the configuration of the AzureRM provider.
data "azurerm_client_config" "current" {}

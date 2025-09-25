terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
  name     = "rg-transfer-microservices-${var.azure_location_slug}"
  location = var.azure_location
  tags     = var.bank_microservices_tags
}

# # =========================================================================================
# # Microservice -> API Gateway
# # =========================================================================================
# resource "azurerm_service_plan" "app_service_plan_apigateway" {
#   name                = "app-service-plan-apigateway-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.bank_microservices_tags
# }

# resource "azurerm_linux_web_app" "app_service_apigateway" {
#   name                = "app-service-apigateway-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   service_plan_id     = azurerm_service_plan.app_service_plan_apigateway.id
#   site_config {
#     always_on = false
#     application_stack {
#       docker_image_name = "nginx:latest"
#     }
#   }
#   tags = var.bank_microservices_tags
# }

# # =========================================================================================
# # Microservice -> Transaction
# # =========================================================================================
# resource "azurerm_service_plan" "app_service_plan_transaction" {
#   name                = "app-service-plan-transaction-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.bank_microservices_tags
# }

# resource "azurerm_linux_web_app" "app_service_transaction" {
#   name                = "app-service-transaction-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   service_plan_id     = azurerm_service_plan.app_service_plan_transaction.id
#   site_config {
#     always_on = false
#     application_stack {
#       docker_image_name = "nginx:latest"
#     }
#   }
#   tags = var.bank_microservices_tags
# }


# # =========================================================================================
# # Microservice -> Balance
# # =========================================================================================
# resource "azurerm_service_plan" "app_service_plan_balance" {
#   name                = "app-service-plan-balance-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.bank_microservices_tags
# }

# resource "azurerm_linux_web_app" "app_service_balance" {
#   name                = "app-service-balance-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   service_plan_id     = azurerm_service_plan.app_service_plan_balance.id
#   site_config {
#     always_on = false
#     application_stack {
#       docker_image_name = "nginx:latest"
#     }
#   }
#   tags = var.bank_microservices_tags
# }


# # =========================================================================================
# # Microservice -> Transfer
# # =========================================================================================
# resource "azurerm_service_plan" "app_service_plan_transfer" {
#   name                = "app-service-plan-transfer-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.bank_microservices_tags
# }

# resource "azurerm_linux_web_app" "app_service_transfer" {
#   name                = "app-service-transfer-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   service_plan_id     = azurerm_service_plan.app_service_plan_transfer.id
#   site_config {
#     always_on = false
#     application_stack {
#       docker_image_name = "nginx:latest"
#     }
#   }
#   tags = var.bank_microservices_tags
# }

# # =========================================================================================
# # Microservice -> Notification
# # =========================================================================================
# resource "azurerm_service_plan" "app_service_plan_notification" {
#   name                = "app-service-plan-notification-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.bank_microservices_tags
# }

# resource "azurerm_linux_web_app" "app_service_notification" {
#   name                = "app-service-notification-${var.azure_location_slug}"
#   location            = var.azure_location
#   resource_group_name = azurerm_resource_group.rg_bank_microservices.name
#   service_plan_id     = azurerm_service_plan.app_service_plan_notification.id
#   site_config {
#     always_on = false
#     application_stack {
#       docker_image_name = "nginx:latest"
#     }
#   }
#   tags = var.bank_microservices_tags
# }

# ----------------------------------------------------------
# Módulo: Bases de Datos MSSQL
# ----------------------------------------------------------
# Llama al módulo para el microservicio de 'Transaction'.
module "mssql_transaction" {
  source              = "./modules/mssql-database"
  name                = "transaction"
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  admin_username      = var.tmp_username
  admin_password      = var.tmp_password
  sku_name            = var.mssql_server_sku
  tags                = var.bank_microservices_tags
}

# Llama al módulo para el microservicio de 'Balance'.
module "mssql_balance" {
  source              = "./modules/mssql-database"
  name                = "balance"
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  admin_username      = var.tmp_username
  admin_password      = var.tmp_password
  sku_name            = var.mssql_server_sku
  tags                = var.bank_microservices_tags
}

# Llama al módulo para el microservicio de 'Transfer'.
module "mssql_transfer" {
  source              = "./modules/mssql-database"
  name                = "transfer"
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  admin_username      = var.tmp_username
  admin_password      = var.tmp_password
  sku_name            = var.mssql_server_sku
  tags                = var.bank_microservices_tags
}

# ----------------------------------------------------------
# Módulo: Base de Datos NoSQL (CosmosDB)
# ----------------------------------------------------------
# Llama al módulo para la cuenta de CosmosDB y la base de datos SQL asociada.
module "cosmosdb" {
  source              = "./modules/cosmosdb"
  name                = "notification"
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  tags                = var.bank_microservices_tags
}

# ----------------------------------------------------------
# Módulo: Funciones y Storage (Dead-Letter)
# ----------------------------------------------------------
# Llama al módulo para la función de manejo de errores.
module "dead_letter_handler" {
  source              = "./modules/dead-letter-function"
  name                = "dead-letter"
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  resource_group_name = azurerm_resource_group.rg_bank_microservices.name
  tags                = var.bank_microservices_tags
}

# ----------------------------------------------------------
# Azure Service Bus (Módulo)
# ----------------------------------------------------------
module "transfer_service_bus" {
  source              = "./modules/service-bus"
  resource_group_name      = azurerm_resource_group.rg_bank_microservices.name
  location            = var.azure_location
  location_slug       = var.azure_location_slug
  tags                = var.bank_microservices_tags
  sku                 = "Standard" # Usa la variable que definiste
}


# ----------------------------------------------------------
# Módulo: Observabilidad (Application Insights)
# ----------------------------------------------------------
# Llama al módulo para la telemetría de la aplicación.
module "observability" {
  source              = "./modules/observability"
  name                = "application-insights-transfer-app-${var.azure_location_slug}"
  location            = var.azure_location
  resource_group_name      = azurerm_resource_group.rg_bank_microservices.name
  application_type    = "web"
  tags                = var.bank_microservices_tags
}

# ------------------------------------
# Módulo: Gestión de Secretos (Key Vault)
# ------------------------------------
# Llama al módulo para el Key Vault.
module "key_vault" {
  source              = "./modules/key-vault"
  name                = "kv${var.azure_location}${random_string.suffix.result}"
  location            = var.azure_location
  resource_group_name      = azurerm_resource_group.rg_bank_microservices.name
  sku_name            = "standard"
  tags                = var.bank_microservices_tags
}

# Agrega un recurso aleatorio para que el nombre del Key Vault sea único
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}


# ---------------------------------------
# Creacion del Servicio Azure Service Bus
# ---------------------------------------

resource "azurerm_servicebus_namespace" "namespace" {
  name                = "service-bus-transfer-app-${var.location_slug}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  tags                = var.tags
}

# ---------------------------------------
# Creacion del Topic en Azure Service Bus
# ---------------------------------------

resource "azurerm_servicebus_topic" "bank_transfer_topic" {
  name                = "bank-transfer"
  namespace_id        = azurerm_servicebus_namespace.namespace.id
}

# ------------------------------------
# Suscripciones y Reglas de Filtro
# ------------------------------------

# MS Transaction: transaction-initiated
# -------------------------------------
resource "azurerm_servicebus_subscription" "transaction_initiated" {
  name                = "transaction-initiated"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transaction_initiated_rule" {
  name                = "transaction-initiated"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transaction_initiated.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transaction_initiated.name
  }
}

# MS Transaction: transaction-completed
# -------------------------------------
resource "azurerm_servicebus_subscription" "transaction_completed" {
  name                = "transaction-completed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transaction_completed_rule" {
  name                = "transaction-completed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transaction_completed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transaction_completed.name
  }
}

# MS Transaction: transaction-failed
# -------------------------------------
resource "azurerm_servicebus_subscription" "transaction_failed" {
  name                = "transaction-failed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transaction_failed_rule" {
  name                = "transaction-failed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transaction_failed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transaction_failed.name
  }
}

# MS Balance: balance-initiated
# -------------------------------------
resource "azurerm_servicebus_subscription" "balance_initiated" {
  name                = "balance-initiated"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "balance_initiated_rule" {
  name                = "balance-initiated"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.balance_initiated.id
  correlation_filter {
    label = azurerm_servicebus_subscription.balance_initiated.name
  }
}

# MS Balance: balance-confirmed
# -------------------------------------
resource "azurerm_servicebus_subscription" "balance_confirmed" {
  name                = "balance-confirmed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "balance_confirmed_rule" {
  name                = "balance-confirmed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.balance_confirmed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.balance_confirmed.name
  }
}

# MS Balance: balance-failed
# -------------------------------------
resource "azurerm_servicebus_subscription" "balance_failed" {
  name                = "balance-failed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "balance_failed_rule" {
  name                = "balance-failed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.balance_failed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.balance_failed.name
  }
}

# MS Transfer: transfer-initiated
# -------------------------------------
resource "azurerm_servicebus_subscription" "transfer_initiated" {
  name                = "transfer-initiated"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transfer_initiated_rule" {
  name                = "transfer-initiated"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transfer_initiated.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transfer_initiated.name
  }
}

# MS Transfer: transfer-confirmed
# -------------------------------------
resource "azurerm_servicebus_subscription" "transfer_confirmed" {
  name                = "transfer-confirmed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transfer_confirmed_rule" {
  name                = "transfer-confirmed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transfer_confirmed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transfer_confirmed.name
  }
}

# MS Transfer: transfer-failed
# -------------------------------------
resource "azurerm_servicebus_subscription" "transfer_failed" {
  name                = "transfer-failed"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transfer_failed_rule" {
  name                = "transfer-failed"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transfer_failed.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transfer_failed.name
  }
}

# MS Transfer: transfer-confirmed-balance
# ----------------------------------------
resource "azurerm_servicebus_subscription" "transfer_confirmed_balance" {
  name                = "transfer-confirmed-balance"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transfer_confirmed_balance_rule" {
  name                = "transfer-confirmed-balance"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transfer_confirmed_balance.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transfer_confirmed_balance.name
  }
}

# MS Transfer: transfer-failed-balance
# -------------------------------------
resource "azurerm_servicebus_subscription" "transfer_failed_balance" {
  name                = "transfer-failed-balance"
  topic_id            = azurerm_servicebus_topic.bank_transfer_topic.id
  max_delivery_count  = 10
  auto_delete_on_idle = "P14D"
  lock_duration       = "PT30S"
}

resource "azurerm_servicebus_subscription_rule" "transfer_failed_balance_rule" {
  name                = "transfer-failed-balance"
  filter_type = "CorrelationFilter"
  subscription_id     = azurerm_servicebus_subscription.transfer_failed_balance.id
  correlation_filter {
    label = azurerm_servicebus_subscription.transfer_failed_balance.name
  }
}
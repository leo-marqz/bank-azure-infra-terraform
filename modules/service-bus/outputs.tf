output "namespace_id" {
  description = "The ID of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.namespace.id
}

output "namespace_name" {
  description = "The name of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.namespace.name
}

# Exportar la clave de acceso principal para ser usada en App Services/Functions
output "primary_connection_string" {
  description = "The Primary Connection String for the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.namespace.default_primary_connection_string
  sensitive   = true # Marca esto como sensible
}
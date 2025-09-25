
output "function_app_name" {
  description = "The name of the Azure Function App."
  value       = azurerm_linux_function_app.function_app.name
}


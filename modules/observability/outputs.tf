
output "instrumentation_key" {
  description = "The instrumentation key for Application Insights."
  value       = azurerm_application_insights.app_insights.instrumentation_key
  sensitive   = true
}

output "app_id" {
  description = "The Application ID for Application Insights."
  value       = azurerm_application_insights.app_insights.app_id
}

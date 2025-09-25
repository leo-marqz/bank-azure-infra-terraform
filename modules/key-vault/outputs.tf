
output "vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.key_vault.id
}

output "vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "key_vault_ids" {
  value       = { for k, v in azurerm_key_vault.kv : k => v.id }
  description = "Map of Key Vault IDs"
}

output "key_vault_uris" {
  value       = { for k, v in azurerm_key_vault.kv : k => v.vault_uri }
  description = "Map of Key Vault URIs"
}

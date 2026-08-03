variable "key_vault" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    sku_name                    = optional(string, "standard")
    soft_delete_retention_days  = optional(number, 7)
    purge_protection_enabled    = optional(bool, true)
    enabled_for_disk_encryption = optional(bool, true)
    network_acls_default_action = optional(string, "Deny")
    network_acls_ip_rules       = optional(list(string), [])
    network_acls_subnet_ids     = optional(list(string), [])
  }))
}

variable "key_vault_secrets" {
  type = map(object({
    name          = string
    value         = string
    key_vault_key = string
  }))
  default     = {}
  description = "Map of secrets to store in Key Vault"
}


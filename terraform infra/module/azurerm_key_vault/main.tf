data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  for_each                    = var.key_vault
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = lookup(each.value, "sku_name", "standard")
  soft_delete_retention_days  = lookup(each.value, "soft_delete_retention_days", 7)
  purge_protection_enabled    = lookup(each.value, "purge_protection_enabled", true)
  enabled_for_disk_encryption = lookup(each.value, "enabled_for_disk_encryption", true)

  network_acls {
    bypass                     = "AzureServices"
    default_action             = lookup(each.value, "network_acls_default_action", "Deny")
    ip_rules                   = lookup(each.value, "network_acls_ip_rules", [])
    virtual_network_subnet_ids = lookup(each.value, "network_acls_subnet_ids", [])
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Update"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]

    storage_permissions = [
      "Get", "List"
    ]
  }
}

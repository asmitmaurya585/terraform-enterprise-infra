resource "azurerm_mysql_flexible_server" "mysql" {
  for_each               = var.mysql_server
  name                   = each.value.name
  resource_group_name    = each.value.resource_group_name
  location               = each.value.location
  administrator_login    = each.value.administrator_login
  administrator_password = each.value.administrator_password
  sku_name               = lookup(each.value, "sku_name", "B_Standard_B1ms")
  version                = lookup(each.value, "version", "8.0.21")
  zone                   = lookup(each.value, "zone", null)

  storage {
    size_gb = lookup(each.value, "storage_size_gb", 20)
    iops    = lookup(each.value, "storage_iops", 360)
  }

  delegated_subnet_id = lookup(each.value, "delegated_subnet_id", null)
  private_dns_zone_id = lookup(each.value, "private_dns_zone_id", null)
}

resource "azurerm_mysql_flexible_database" "db" {
  for_each            = var.mysql_database
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql[each.value.server_key].name
  charset             = lookup(each.value, "charset", "utf8mb4")
  collation           = lookup(each.value, "collation", "utf8mb4_unicode_ci")
}

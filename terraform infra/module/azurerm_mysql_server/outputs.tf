output "mysql_server_ids" {
  value       = { for k, v in azurerm_mysql_flexible_server.mysql : k => v.id }
  description = "Map of MySQL Flexible Server IDs"
}

output "mysql_server_fqdns" {
  value       = { for k, v in azurerm_mysql_flexible_server.mysql : k => v.fqdn }
  description = "Map of MySQL Flexible Server FQDNs"
}

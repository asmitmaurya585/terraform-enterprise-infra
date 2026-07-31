output "action_group_ids" {
  value       = { for k, v in azurerm_monitor_action_group.ag : k => v.id }
  description = "Map of Monitor Action Group IDs"
}

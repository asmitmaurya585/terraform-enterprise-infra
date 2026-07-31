output "workspace_ids" {
  value       = { for k, v in azurerm_log_analytics_workspace.law : k => v.id }
  description = "Map of Log Analytics Workspace IDs"
}

output "workspace_customer_ids" {
  value       = { for k, v in azurerm_log_analytics_workspace.law : k => v.workspace_id }
  description = "Map of Log Analytics Workspace Customer IDs"
}

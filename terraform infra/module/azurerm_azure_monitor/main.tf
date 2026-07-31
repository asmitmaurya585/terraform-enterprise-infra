resource "azurerm_monitor_action_group" "ag" {
  for_each            = var.action_groups
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  short_name          = each.value.short_name

  email_receiver {
    name                    = each.value.email_name
    email_address           = each.value.email_address
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  for_each                   = var.diagnostic_settings
  name                       = each.value.name
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_metric_alert" "alert" {
  for_each            = var.metric_alerts
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  scopes              = [each.value.scopes]
  description         = each.value.description
  severity            = lookup(each.value, "severity", 3)

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id = each.value.action_group_id
  }
}

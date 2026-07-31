variable "action_groups" {
  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string
    email_name          = string
    email_address       = string
  }))
  default = {}
}

variable "diagnostic_settings" {
  type = map(object({
    name                       = string
    target_resource_id         = string
    log_analytics_workspace_id = string
  }))
  default = {}
}

variable "metric_alerts" {
  type = map(object({
    name                = string
    resource_group_name = string
    scopes              = string
    description         = string
    severity            = optional(number, 3)
    metric_namespace    = string
    metric_name         = string
    aggregation         = string
    operator            = string
    threshold           = number
    action_group_id     = string
  }))
  default = {}
}

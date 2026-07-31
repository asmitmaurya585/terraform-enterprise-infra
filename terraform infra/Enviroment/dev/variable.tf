variable "asmitrg" {
  type        = any
  description = "Map of resource groups configuration"
}

variable "asmitsub" {
  type        = any
  description = "Map of subnets configuration"
}

variable "asmitvnet" {
  type        = any
  description = "Map of virtual networks configuration"
}

variable "asmitvm" {
  type = map(object({
    nic_name                        = string
    subnet_name                     = string
    virtual_network_name            = string
    ip_configuration_name           = string
    private_ip_address_allocation   = string
    vm_name                         = string
    location                        = string
    resource_group_name             = string
    vm_size                         = string
    admin_username                  = string
    admin_password                  = string
    publisher                       = string
    offer                           = string
    sku                             = string
    version                         = string
    os_disk_name                    = string
    caching                         = string
    create_option                   = string
    managed_disk_type               = string
    computer_name                   = string
    disable_password_authentication = optional(bool, false)
  }))
  description = "Map of Linux virtual machines configuration"
}

variable "bastion_host" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    ip_configuration_name = string
    subnet_name           = string
    virtual_network_name  = string
    public_ip_name        = string
    sku                   = optional(string, "Basic")
  }))
  description = "Map of Bastion hosts configuration"
}

variable "asmitip" {
  type        = any
  description = "Map of public IPs configuration"
}

variable "nat_gateway" {
  type        = any
  description = "Map of NAT gateway configuration"
}

variable "nat_gateway1" {
  type        = any
  description = "Map of NAT gateway public IP associations configuration"
}

variable "subnet_association" {
  type        = any
  description = "Map of NAT gateway subnet associations configuration"
}

variable "nsg" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    nic_name             = optional(string)
    subnet_name          = optional(string)
    virtual_network_name = optional(string)

    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  description = "Map of Network Security Groups configuration"
}

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
  default     = {}
  description = "Map of Key Vaults configuration"
}

variable "log_analytics_workspace" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = optional(string, "PerGB2018")
    retention_in_days   = optional(number, 30)
  }))
  default     = {}
  description = "Map of Log Analytics Workspaces configuration"
}

variable "action_groups" {
  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string
    email_name          = string
    email_address       = string
  }))
  default     = {}
  description = "Map of Monitor Action Groups configuration"
}

variable "diagnostic_settings" {
  type = map(object({
    name                       = string
    target_resource_id         = string
    log_analytics_workspace_id = string
  }))
  default     = {}
  description = "Map of Monitor Diagnostic Settings configuration"
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
  default     = {}
  description = "Map of Monitor Metric Alerts configuration"
}

variable "mysql_server" {
  type = map(object({
    name                   = string
    resource_group_name    = string
    location               = string
    administrator_login    = string
    administrator_password = string
    sku_name               = optional(string, "B_Standard_B1ms")
    version                = optional(string, "8.0.21")
    zone                   = optional(string)
    storage_size_gb        = optional(number, 20)
    storage_iops           = optional(number, 360)
    delegated_subnet_id    = optional(string)
    private_dns_zone_id    = optional(string)
  }))
  default     = {}
  description = "Map of MySQL Flexible Servers configuration"
}

variable "mysql_database" {
  type = map(object({
    name                = string
    resource_group_name = string
    server_key          = string
    charset             = optional(string, "utf8mb4")
    collation           = optional(string, "utf8mb4_unicode_ci")
  }))
  default     = {}
  description = "Map of MySQL Flexible Databases configuration"
}

variable "app_gateway" {
  type = map(object({
    name                                   = string
    location                               = string
    resource_group_name                    = string
    sku_name                               = string
    sku_tier                               = string
    capacity                               = number
    subnet_name                            = string
    virtual_network_name                   = string
    public_ip_name                         = string
    gateway_ip_configuration_name          = string
    frontend_port_name                     = string
    frontend_port                          = number
    https_frontend_port_name               = optional(string, "https-port")
    https_frontend_port                    = optional(number, 443)
    frontend_ip_configuration_name         = string
    ssl_certificate_name                   = optional(string)
    ssl_certificate_data                   = optional(string)
    ssl_certificate_password               = optional(string)
    key_vault_secret_id                    = optional(string)
    linux_nic_name                         = string
    backend_nic_name                       = string
    linux_backend_pool_name                = string
    backend_backend_pool_name              = string
    linux_backend_http_settings_name       = string
    backend_backend_http_settings_name     = string
    cookie_based_affinity                  = string
    linux_backend_http_settings_port       = number
    backend_backend_http_settings_port     = number
    linux_backend_http_settings_protocol   = string
    backend_backend_http_settings_protocol = string
    request_timeout                        = number
    linux_listener_name                    = string
    backend_listener_name                  = string
    http_listener_protocol                 = string
    linux_host_name                        = string
    backend_host_name                      = string
    linux_rule_name                        = string
    backend_rule_name                      = string
    rule_type                              = string
    linux_rule_priority                    = number
    backend_rule_priority                  = number
  }))
  description = "Map of Application Gateways configuration"
}

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
}

variable "mysql_database" {
  type = map(object({
    name                = string
    resource_group_name = string
    server_key          = string
    charset             = optional(string, "utf8mb4")
    collation           = optional(string, "utf8mb4_unicode_ci")
  }))
  default = {}
}

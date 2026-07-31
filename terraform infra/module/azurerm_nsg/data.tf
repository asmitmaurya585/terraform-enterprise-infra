data "azurerm_network_interface" "nic" {
  for_each            = { for k, v in var.nsg : k => v if lookup(v, "nic_name", null) != null && lookup(v, "nic_name", "") != "" }
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "nsg_subnet" {
  for_each             = { for k, v in var.nsg : k => v if lookup(v, "subnet_name", null) != null && lookup(v, "subnet_name", "") != "" }
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
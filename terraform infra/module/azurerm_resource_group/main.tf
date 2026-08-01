resource "azurerm_resource_group" "asmit1" {
  for_each = var.asmiteg

  name     = each.value.name
  location = each.value.location
}
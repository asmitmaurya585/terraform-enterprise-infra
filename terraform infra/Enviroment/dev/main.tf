module "resource_group" {
  source  = "../../module/azurerm_resource_group"
  asmitrg = var.asmitrg
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_virtual_network"
  asmitvnet  = var.asmitvnet
}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../module/azurerm_subnet"
  asmitsub   = var.asmitsub
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../module/azurerm_puplic_ip"
  asmitip    = var.asmitip
}

module "nat_gateway" {
  depends_on         = [module.public_ip, module.subnet]
  source             = "../../module/azurerm_nat_gateway"
  nat_gateway        = var.nat_gateway
  nat_gateway1       = var.nat_gateway1
  subnet_association = var.subnet_association
}

module "bastion_host" {
  depends_on   = [module.public_ip, module.subnet]
  source       = "../../module/azurerm_bastion"
  bastion_host = var.bastion_host
}

module "virtual_machine" {
  depends_on = [module.public_ip, module.subnet]
  source     = "../../module/azurerm_linux_virtual_machine"
  asmitvm    = var.asmitvm
}

module "nsg" {
  depends_on = [module.virtual_machine]
  source     = "../../module/azurerm_nsg"
  nsg        = var.nsg
}

module "key_vault" {
  depends_on        = [module.resource_group]
  source            = "../../module/azurerm_key_vault"
  key_vault         = var.key_vault
  key_vault_secrets = var.key_vault_secrets
}


module "log_analytics_workspace" {
  depends_on              = [module.resource_group]
  source                  = "../../module/azurerm_log_analytics_workspace"
  log_analytics_workspace = var.log_analytics_workspace
}

module "azure_monitor" {
  depends_on          = [module.resource_group, module.log_analytics_workspace]
  source              = "../../module/azurerm_azure_monitor"
  action_groups       = var.action_groups
  diagnostic_settings = var.diagnostic_settings
  metric_alerts       = var.metric_alerts
}

module "mysql_server" {
  depends_on     = [module.resource_group, module.subnet]
  source         = "../../module/azurerm_mysql_server"
  mysql_server   = var.mysql_server
  mysql_database = var.mysql_database
}

module "application_gateway" {
  depends_on  = [module.virtual_machine, module.public_ip, module.subnet]
  source      = "../../module/azurerm_application_gateway"
  app_gateway = var.app_gateway
}

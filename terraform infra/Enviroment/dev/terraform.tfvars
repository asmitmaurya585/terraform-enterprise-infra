asmitrg = {
  rg1 = {
    name     = "devrg"
    location = "centralindia"
  }
  rg2 = {
    name     = "devrg2"
    location = "centralindia"
  }
  rg3 = {
    name     = "devrg3"
    location = "centralindia"
  }
}

asmitvnet = {
  vnet1 = {
    name                = "devvent"
    location            = "centralindia"
    resource_group_name = "devrg"
    address_space       = ["10.0.0.0/16"]
  }
}

asmitsub = {
  sub1 = {
    name                 = "subnet1"
    resource_group_name  = "devrg"
    virtual_network_name = "devvent"
    address_prefixes     = ["10.0.1.0/24"]
  }

  sub2 = {
    name                 = "subnet2"
    resource_group_name  = "devrg"
    virtual_network_name = "devvent"
    address_prefixes     = ["10.0.2.0/24"]
  }

  sub3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "devrg"
    virtual_network_name = "devvent"
    address_prefixes     = ["10.0.3.0/26"]
  }

  sub4 = {
    name                 = "gateway"
    resource_group_name  = "devrg"
    virtual_network_name = "devvent"
    address_prefixes     = ["10.0.4.0/26"]
  }
}

asmitip = {
  pip1 = {
    name                = "Nat_pip"
    resource_group_name = "devrg"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  pip2 = {
    name                = "bastion_pip"
    resource_group_name = "devrg"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  pip3 = {
    name                = "load_pip"
    resource_group_name = "devrg"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nat_gateway = {
  subnetvm1 = {
    name                    = "devnat"
    location                = "centralindia"
    resource_group_name     = "devrg"
    sku_name                = "Standard"
    idle_timeout_in_minutes = 10
    zones                   = null
  }
}

nat_gateway1 = {
  subnetvm1 = {
    public_ip_name      = "Nat_pip"
    resource_group_name = "devrg"
  }
}

subnet_association = {
  subnet4 = {
    subnet_name         = "subnet1"
    vnet_name           = "devvent"
    resource_group_name = "devrg"
  }

  subnet3 = {
    subnet_name         = "subnet2"
    vnet_name           = "devvent"
    resource_group_name = "devrg"
  }
}

bastion_host = {
  bastion1 = {
    name                  = "devbastion"
    location              = "centralindia"
    resource_group_name   = "devrg"
    ip_configuration_name = "configuration"
    subnet_name           = "AzureBastionSubnet"
    virtual_network_name  = "devvent"
    public_ip_name        = "bastion_pip"
  }
}

asmitvm = {
  vm1 = {
    nic_name                        = "nicdev"
    subnet_name                     = "subnet1"
    virtual_network_name            = "devvent"
    ip_configuration_name           = "internal"
    private_ip_address_allocation   = "Dynamic"
    vm_name                         = "frontend-dev"
    location                        = "centralindia"
    resource_group_name             = "devrg"
    vm_size                         = "Standard_B2as_v2"
    admin_username                  = "frontend-dev"
    admin_password                  = "asmit@123456"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    os_disk_name                    = "frontend-osdisk"
    caching                         = "ReadWrite"
    create_option                   = "FromImage"
    managed_disk_type               = "Standard_LRS"
    computer_name                   = "frontend-host"
    disable_password_authentication = false
  }

  vm2 = {
    nic_name                        = "nicdev2"
    subnet_name                     = "subnet2"
    virtual_network_name            = "devvent"
    ip_configuration_name           = "internal"
    private_ip_address_allocation   = "Dynamic"
    vm_name                         = "backend-dev"
    location                        = "centralindia"
    resource_group_name             = "devrg"
    vm_size                         = "Standard_B2as_v2"
    admin_username                  = "backend-dev"
    admin_password                  = "asmit@123456"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    os_disk_name                    = "backend-osdisk"
    caching                         = "ReadWrite"
    create_option                   = "FromImage"
    managed_disk_type               = "Standard_LRS"
    computer_name                   = "backend-host"
    disable_password_authentication = false
  }
}

nsg = {
  appgw = {
    name                 = "appgw-nsg"
    location             = "centralindia"
    resource_group_name  = "devrg"
    subnet_name          = "gateway"
    virtual_network_name = "devvent"

    security_rules = [
      {
        name                       = "Allow-Internet-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-Internet-HTTPS"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-GatewayManager-HealthProbes"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "65200-65535"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      }
    ]
  }

  linux = {
    name                = "devnsg"
    location            = "centralindia"
    resource_group_name = "devrg"
    nic_name            = "nicdev"

    security_rules = [
      {
        name                       = "Allow-AppGateway-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "10.0.4.0/26" # Application Gateway Subnet
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-AppGateway-HTTPS"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "10.0.4.0/26" # Application Gateway Subnet
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-Bastion-SSH"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.0.3.0/26" # Azure Bastion Subnet
        destination_address_prefix = "*"
      },
      {
        name                       = "Deny-All-Inbound"
        priority                   = 4096
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  backend = {
    name                = "backend-nsg"
    location            = "centralindia"
    resource_group_name = "devrg"
    nic_name            = "nicdev2"

    security_rules = [
      {
        name                       = "Allow-Frontend-Port3000"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3000"
        source_address_prefix      = "10.0.1.0/24" # Frontend Subnet
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-Bastion-SSH"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.0.3.0/26" # Azure Bastion Subnet
        destination_address_prefix = "*"
      },
      {
        name                       = "Deny-All-Inbound"
        priority                   = 4096
        direction                  = "Inbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

key_vault = {
  kv1 = {
    name                        = "dev-keyvault-b18"
    location                    = "centralindia"
    resource_group_name         = "devrg"
    sku_name                    = "standard"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = true
    enabled_for_disk_encryption = true
    network_acls_default_action = "Allow"
    network_acls_ip_rules       = ["122.161.73.126"]
    network_acls_subnet_ids     = []
  }
}

key_vault_secrets = {
  secret1 = {
    name          = "db-password"
    value         = "SuperSecretPassword123!"
    key_vault_key = "kv1"
  }
}


log_analytics_workspace = {
  law1 = {
    name                = "dev-law-b18"
    location            = "centralindia"
    resource_group_name = "devrg"
    sku                 = "PerGB2018"
    retention_in_days   = 30
  }
}

action_groups = {
  ag1 = {
    name                = "dev-action-group"
    resource_group_name = "devrg"
    short_name          = "devag"
    email_name          = "admin-email"
    email_address       = "admin@example.com"
  }
}

diagnostic_settings = {}
metric_alerts       = {}

mysql_server = {
  mysql1 = {
    name                   = "dev-mysql-server-b18-v2"
    location               = "southindia" # Supported region for MySQL Flexible Server
    resource_group_name    = "devrg"
    administrator_login    = "mysqladmin"
    administrator_password = "Asmit@123456"
    sku_name               = "B_Standard_B1ms"
    version                = "8.0.21"
    storage_size_gb        = 20
    storage_iops           = 360
  }
}

mysql_database = {
  db1 = {
    name                = "appdb"
    resource_group_name = "devrg"
    server_key          = "mysql1"
    charset             = "utf8mb4"
    collation           = "utf8mb4_unicode_ci"
  }
}

app_gateway = {
  agw1 = {
    name                                   = "dev-appgateway"
    location                               = "centralindia"
    resource_group_name                    = "devrg"
    sku_name                               = "Standard_v2"
    sku_tier                               = "Standard_v2"
    capacity                               = 2
    subnet_name                            = "gateway"
    virtual_network_name                   = "devvent"
    public_ip_name                         = "load_pip"
    gateway_ip_configuration_name          = "appGatewayIpConfig"
    frontend_port_name                     = "http-port"
    frontend_port                          = 80
    https_frontend_port_name               = "https-port"
    https_frontend_port                    = 443
    frontend_ip_configuration_name         = "appGatewayFrontendIP"
    ssl_certificate_name                   = "appgw-ssl-cert"
    ssl_certificate_password               = "Asmit123456"
    linux_nic_name                         = "nicdev"
    backend_nic_name                       = "nicdev2"
    linux_backend_pool_name                = "linux-frontend-backend-pool"
    backend_backend_pool_name              = "linux-backend-pool"
    linux_backend_http_settings_name       = "linux-frontend-http-setting"
    backend_backend_http_settings_name     = "linux-backend-http-setting"
    cookie_based_affinity                  = "Disabled"
    linux_backend_http_settings_port       = 80
    backend_backend_http_settings_port     = 3000
    linux_backend_http_settings_protocol   = "Http"
    backend_backend_http_settings_protocol = "Http"
    request_timeout                        = 60
    linux_listener_name                    = "linux-frontend-listener"
    backend_listener_name                  = "linux-backend-listener"
    http_listener_protocol                 = "Http"
    linux_host_name                        = "frontend.b18g66.online"
    backend_host_name                      = "backend.b18g66.online"
    linux_rule_name                        = "linux-frontend-rule"
    backend_rule_name                      = "linux-backend-rule"
    rule_type                              = "Basic"
    linux_rule_priority                    = 10
    backend_rule_priority                  = 20
  }
}

asmitrg = {
  rg1 = {
    name     = "rgamit"
    location = "centralindia"
  }
}

asmitstg = {
  stg1 = {
    stg_name                 = "asmitstgpreprod2026"
    resource_group_name      = "rgamit"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    con_name                 = "asmitcon"
    container_access_type    = "private"
  }
}
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }

backend "azurerm" {
    resource_group_name  = "rgamit"
    storage_account_name = "asmitstorage"
    container_name       = "asmitcon"
    key                  = "preprod.terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}
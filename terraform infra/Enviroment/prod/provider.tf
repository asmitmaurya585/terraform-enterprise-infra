terraform {
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
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

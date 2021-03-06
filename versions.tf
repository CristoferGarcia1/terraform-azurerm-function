terraform {
  required_version = "> 0.12.26"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.21.0"
    }
  }
}

provider "azurerm" {
   features {}

   skip_provider_registration = true
}
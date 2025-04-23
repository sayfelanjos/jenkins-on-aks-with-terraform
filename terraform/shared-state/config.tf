terraform {
  required_version = "~> 1.11.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.26.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "5c61423a-be60-4fbb-a575-7999e5429920"
  features {}
}
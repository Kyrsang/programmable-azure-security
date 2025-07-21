terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~> 3.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "add_user" {
  source = "./references/azure-security/add_user/"
  user_principal_name = "john.doe@contoso.com"
  display_name        = "John Doe"
  mail_nickname       = "johndoe"
  password            = "P@ssword123!"
}


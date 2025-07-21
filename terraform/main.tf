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

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

module "add_user" {
  source = "./references/azure-security/chapter1/1_add_user/"
  user_principal_name = "john.doe@contoso.com"
  display_name        = "John Doe"
  mail_nickname       = "johndoe"
  password            = "P@ssword123!"
}

module "add_service_principal" {
  source = "./references/azure-security/chapter1/2_add_service_principal"
  application_display_name = "myApp"
}

module "add_managed_identity" {
  source              = "./references/azure-security/chapter1/3_managed_identity"
  identity_name       = "example-managed-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}
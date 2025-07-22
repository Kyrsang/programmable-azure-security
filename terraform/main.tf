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

resource "azurerm_virtual_network" "this" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "user" {
  source = "./references/azure-security/chapter1/1_user/"
  user_principal_name = "john.doe@contoso.com"
  display_name        = "John Doe"
  mail_nickname       = "johndoe"
  password            = "P@ssword123!"
}

module "service_principal" {
  source = "./references/azure-security/chapter1/2_service_principal"
  application_display_name = "myApp"
}

module "managed_identity_user_assigned" {
  source              = "./references/azure-security/chapter1/3_managed_identity_user_assigned"
  identity_name       = "example-managed-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "managed_identity_system_assigned" {
  source              = "./references/azure-security/chapter1/3_managed_identity_user_assigned"
  identity_name       = "example-managed-identity"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "virtual_machine_with_system_assigned_managed_identity" {
  source              = "./references/azure-security/chapter1/4_managed_identity_system_assigned"
  vm_name             = "example-vm"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  vm_spec             = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "somePassword1!"
  subnet_id           = azurerm_subnet.this.id
}

module "role_assignment_on_service_principal" {
    source            = "./references/azure-security/chapter2/1_built_in_roles"
    principal_id      = module.service_principal.object_id
    role_names        = ["Contributor", "User Access Administrator"]
    scope             = azurerm_resource_group.this.id
}

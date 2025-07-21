terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37.0"
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


## Example: Call networking module
#module "networking" {
#  source         = "./modules/networking"
#  vnet_name      = var.vnet_name
#  address_space  = var.address_space
#  location       = var.location
#  resource_group = var.resource_group_name
#}
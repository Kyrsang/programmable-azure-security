variable "identity_name" {
  type        = string
  description = "Name of the user assigned managed identity"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}
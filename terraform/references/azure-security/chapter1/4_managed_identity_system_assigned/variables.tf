variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "subnet_id" {
  type        = string
  description = "The resource ID of the subnet where the network interface will be connected."
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "vm_spec" {
  type        = string
  description = "The size of the VM instance, e.g., Standard_DS1_v2."
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  type        = string
  description = "The admin username for the VM."
  default     = "adminuser"
}

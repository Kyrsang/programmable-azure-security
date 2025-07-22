variable "principal_id" {
  description = "The object ID of the principal (user, SP, or managed identity)"
  type        = string
}

variable "role_names" {
  description = "A list of built-in role names to assign"
  type        = list(string)
}

variable "scope" {
  description = "The scope at which to assign the role (e.g., resource group, subscription)"
  type        = string
}
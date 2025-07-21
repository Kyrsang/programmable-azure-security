variable "user_principal_name" {
  type        = string
  description = "The user principal name (UPN) of the Azure AD user"
  default     = "john.doe@contoso.com"
}

variable "display_name" {
  type        = string
  description = "The display name of the Azure AD user"
  default     = "John Doe"
}

variable "mail_nickname" {
  type        = string
  description = "The mail nickname of the Azure AD user"
  default     = "johndoe"
}

variable "password" {
  type        = string
  description = "The initial password for the Azure AD user"
  default     = "P@ssword123!"
  sensitive   = true
}

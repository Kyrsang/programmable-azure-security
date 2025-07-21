data "azuread_client_config" "current" {}

resource "azuread_application" "application" {
  display_name = var.application_display_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "service_principal" {
  client_id               = azuread_application.application.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}
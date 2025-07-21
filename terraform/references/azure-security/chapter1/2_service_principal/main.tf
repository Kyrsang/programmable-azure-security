data "azuread_client_config" "this" {}

resource "azuread_application" "this" {
  display_name = var.application_display_name
  owners       = [data.azuread_client_config.this.object_id]
}

resource "azuread_service_principal" "this" {
  client_id                    = azuread_application.this.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.this.object_id]
}
data "azurerm_role_definition" "roles" {
  for_each = toset(var.role_names)
  name     = each.key
}

resource "azurerm_role_assignment" "this" {
  for_each           = data.azurerm_role_definition.roles
  scope              = var.scope
  role_definition_id = each.value.id
  principal_id       = var.principal_id
}
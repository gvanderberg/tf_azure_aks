data "azurerm_subscription" "this" {}

resource "random_string" "password" {
  length  = 32
  upper   = false
  lower   = true
  number  = true
  special = false
}

resource "azuread_application" "this" {
  name       = var.name
  depends_on = [random_string.password]
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
  depends_on     = [azuread_application.this]
}

resource "azuread_service_principal_password" "this" {
  end_date             = "2299-12-30T23:00:00Z"
  service_principal_id = azuread_service_principal.this.id
  value                = random_string.password.result
  depends_on           = [azuread_service_principal.this]
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azuread_service_principal.this.id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_subscription.this.id
  depends_on           = [azuread_service_principal_password.this]
}

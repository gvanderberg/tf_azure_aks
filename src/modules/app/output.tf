output "client_id" {
  value = azuread_application.this.application_id
}

output "client_secret" {
  value = azuread_service_principal_password.this.value
}

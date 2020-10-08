resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

resource "azurerm_management_lock" "this" {
  name       = "can-not-delete-lock"
  scope      = azurerm_resource_group.this.id
  lock_level = "CanNotDelete"
}

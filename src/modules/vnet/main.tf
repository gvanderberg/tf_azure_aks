resource "azurerm_virtual_network" "this" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/8"]
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  address_prefix       = "10.240.0.0/16"
  virtual_network_name = azurerm_virtual_network.this.name
}

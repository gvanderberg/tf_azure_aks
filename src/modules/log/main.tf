resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  sku                 = var.sku
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "this" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  depends_on = [azurerm_log_analytics_workspace.this]
}

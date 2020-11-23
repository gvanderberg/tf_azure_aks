resource "azurerm_log_analytics_workspace" "this" {
  name                = var.analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.analytics_workspace_sku
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "this" {
  solution_name         = "ContainerInsights"
  resource_group_name   = var.resource_group_name
  location              = var.resource_group_location
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  depends_on = [azurerm_log_analytics_workspace.this]
}

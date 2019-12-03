module "rg" {
  source = "./modules/rg"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "log" {
  source = "./modules/log"

  name                = var.log_analytics_workspace_name
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  tags                = var.tags
}

module "app" {
  source = "./modules/app"

  name = format("%s-%s", var.cluster_name, "sp")
}

module "vnet" {
  source = "./modules/vnet"

  network_name        = var.network_name
  location            = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  subnet_name         = var.subnet_name
  tags                = var.tags
}

module "aks" {
  source = "./modules/aks"

  name                         = var.cluster_name
  location                     = module.rg.resource_group_location
  resource_group_name          = module.rg.resource_group_name
  aad_client_app_id            = var.aad_client_app_id
  aad_server_app_id            = var.aad_server_app_id
  aad_server_app_secret        = var.aad_server_app_secret
  aad_tenant_id                = var.aad_tenant_id
  client_id                    = module.app.client_id
  client_secret                = module.app.client_secret
  dns_service_ip               = var.dns_service_ip
  docker_bridge_cidr           = var.docker_bridge_cidr
  kubernetes_dashboard_enabled = var.kubernetes_dashboard_enabled
  kubernetes_version           = var.kubernetes_version
  load_balancer_ip             = var.load_balancer_ip
  load_balancer_sku            = var.load_balancer_sku
  log_analytics_workspace_id   = module.log.log_analytics_workspace_id
  node_count                   = var.node_count
  service_cidr                 = var.service_cidr
  vm_size                      = var.vm_size
  vnet_subnet_id               = module.vnet.subnet_id
  tags                         = var.tags
}

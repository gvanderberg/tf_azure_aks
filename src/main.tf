terraform {
  backend "local" {}
}

module "rg" {
  source = "./modules/resource_group"

  resource_group_create   = var.resource_group_create
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "law" {
  source = "./modules/log_analytics"

  analytics_workspace_name  = var.analytics_workspace_name
  analytics_workspace_sku   = var.analytics_workspace_sku
  resource_group_name       = module.rg.name
  resource_group_location   = module.rg.location
  tags                      = var.tags
}

module "aks" {
  source = "./modules/kubernetes"

  kubernetes_cluster_name      = var.kubernetes_cluster_name
  kubernetes_dashboard_enabled = var.kubernetes_dashboard_enabled
  kubernetes_version           = var.kubernetes_version
  resource_group_name          = module.rg.name
  resource_group_location      = module.rg.location
  admin_username               = "azuresupport"
  admin_password               = var.admin_password
  container_registry_id        = var.container_registry_id
  dns_service_ip               = var.dns_service_ip
  docker_bridge_cidr           = var.docker_bridge_cidr
  docker_config_json           = var.docker_config_json
  load_balancer_ip             = var.load_balancer_ip
  log_analytics_workspace_id   = module.law.id
  node_count                   = var.node_count
  service_cidr                 = var.service_cidr
  slack_username               = var.slack_username
  ssh_key_data                 = var.ssh_key_data
  subnet_name                  = var.subnet_name
  subnet_virtual_network_name  = var.subnet_virtual_network_name
  subnet_resource_group_name   = var.subnet_resource_group_name
  vm_size                      = var.virtual_machine_size
  tags                         = var.tags
}

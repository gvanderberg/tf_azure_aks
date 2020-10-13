provider "azuread" {
  version = "~>0.11.0"
}

provider "azurerm" {
  version = "~>2.30.0"
  features {}
}

provider "helm" {
  version = "~>1.3.1"

  kubernetes {
    host                   = module.aks.host
    username               = module.aks.cluster_username
    password               = module.aks.cluster_password
    client_certificate     = base64decode(module.aks.client_certificate)
    client_key             = base64decode(module.aks.client_key)
    cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  version                = "~>1.13.2"
  host                   = module.aks.host
  username               = module.aks.cluster_username
  password               = module.aks.cluster_password
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

provider "random" {
  version = "~>2.3.0"
}

terraform {
  required_version = "~>0.12.0"
  backend "local" {}
}

module "rg" {
  source = "./modules/resource_group"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  tags                    = var.tags
}

module "law" {
  source = "./modules/log_analytics"

  name                = var.log_analytics_workspace_name
  location            = module.rg.location
  resource_group_name = module.rg.name
  sku                 = var.log_analytics_workspace_sku
  tags                = var.tags
}

module "aks" {
  source = "./modules/kubernetes"

  name                         = var.cluster_name
  location                     = module.rg.location
  resource_group_name          = module.rg.name
  admin_username               = "azuresupport"
  admin_password               = var.admin_password
  container_registry_id        = var.container_registry_id
  dns_service_ip               = var.dns_service_ip
  docker_bridge_cidr           = var.docker_bridge_cidr
  kubernetes_dashboard_enabled = var.kubernetes_dashboard_enabled
  kubernetes_version           = var.kubernetes_version
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

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = format("%s-%s", var.name, "dns")
  kubernetes_version  = var.kubernetes_version

  addon_profile {
    kube_dashboard {
      enabled = var.kubernetes_dashboard_enabled
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  default_node_pool {
    name                  = "agentpool"
    availability_zones    = [1, 2, 3]
    enable_auto_scaling   = true
    enable_node_public_ip = false
    max_count             = var.node_count + 2
    min_count             = var.node_count
    node_count            = var.node_count
    os_disk_size_gb       = "64"
    type                  = "VirtualMachineScaleSets"
    vm_size               = var.vm_size
    vnet_subnet_id        = var.vnet_subnet_id
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku  = var.load_balancer_sku
    service_cidr       = var.service_cidr
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = var.tags
}

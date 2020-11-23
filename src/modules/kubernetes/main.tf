data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
  name                            = var.kubernetes_cluster_name
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  api_server_authorized_ip_ranges = []
  dns_prefix                      = format("%s-%s", var.kubernetes_cluster_name, "dns")
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = format("%s-%s", var.resource_group_name, "nodes")
  private_cluster_enabled         = true
  sku_tier                        = "Free"

  addon_profile {
    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = var.kubernetes_dashboard_enabled
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  default_node_pool {
    name                  = "default"
    enable_auto_scaling   = true
    enable_node_public_ip = true
    availability_zones    = [1, 2, 3]
    max_pods              = "110"
    max_count             = var.node_count + 2
    min_count             = var.node_count
    node_count            = var.node_count
    type                  = "VirtualMachineScaleSets"
    vm_size               = var.vm_size
    vnet_subnet_id        = data.azurerm_subnet.this.id
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_key_data
    }
  }

  windows_profile {
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    # dns_service_ip     = var.dns_service_ip
    # docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku  = "standard"
    # service_cidr       = var.service_cidr
  }

  role_based_access_control {
    azure_active_directory {
      managed = true
    }
    enabled = true
  }

  tags = var.tags
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx/ingress-nginx"
  create_namespace = true
  namespace        = "ingress-system"
  version          = "3.4.0"

  set {
    name  = "controller.image.tag"
    value = "0.40.2"
  }

  set {
    name  = "controller.service.annotations.\"service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal\""
    value = "true"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.load_balancer_ip
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "helm_release" "kured" {
  name       = "kured"
  repository = "https://weaveworks.github.io/kured"
  chart      = "kured/kured"
  namespace  = "kube-system"
  version    = "2.2.0"

  set {
    name  = "image.tag"
    value = "1.5.0"
  }

  depends_on = [azurerm_kubernetes_cluster.this]
}

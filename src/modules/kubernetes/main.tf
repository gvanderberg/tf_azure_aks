data "azuread_group" "this" {
  name = "K8S Administrators Security Group"
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = var.subnet_virtual_network_name
  resource_group_name  = var.subnet_resource_group_name
}

data "azurerm_virtual_network" "this" {
  name                = var.subnet_virtual_network_name
  resource_group_name = var.subnet_resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
  name                            = var.kubernetes_cluster_name
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  api_server_authorized_ip_ranges = []
  dns_prefix                      = format("%s-%s", var.kubernetes_cluster_name, "dns")
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = format("%s-%s", var.resource_group_name, "aks-nodes")
  private_cluster_enabled         = false
  sku_tier                        = "Free"

  addon_profile {
    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  default_node_pool {
    name                  = "agentpool"
    enable_auto_scaling   = false
    enable_node_public_ip = false
    # availability_zones    = [1, 2, 3]
    max_pods              = "110"
    # max_count             = var.node_count + 2
    # min_count             = var.node_count
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
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    load_balancer_sku  = "standard"
    service_cidr       = var.service_cidr
  }

  role_based_access_control {
    azure_active_directory {
      managed                 = true
      admin_group_object_ids  = [data.azuread_group.this.id]
    }
    enabled = true
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks" {
  scope                = azurerm_kubernetes_cluster.this.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_kubernetes_cluster.this.addon_profile[0].oms_agent[0].oms_agent_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "azurerm_role_assignment" "net" {
  scope                = data.azurerm_virtual_network.this.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "azurerm_role_assignment" "acr" {
  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "kubernetes_namespace" "ingress-system" {
  metadata {
    name = "ingress-system"
    labels ={
      "cert-manager.io/disable-validation"=true
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  max_history      = "3"
  namespace        = "ingress-system"
  version          = "3.4.0"

  values = [<<EOF
controller:
  image:
    tag: v0.40.0
  nodeSelector:
    "beta\.kubernetes\.io/os": linux
  replicaCount: 2
  service:
    type: LoadBalancer
defaultBackend:
  nodeSelector:
    "beta\.kubernetes\.io/os": linux
rbac:
  create: true
EOF
  ]

  depends_on = [azurerm_kubernetes_cluster.this, azurerm_role_assignment.net]
}

resource "kubernetes_namespace" "kured-system" {
  metadata {
    name = "kured-system"
  }
}

resource "helm_release" "kured" {
  name        = "kured"
  repository  = "https://weaveworks.github.io/kured"
  chart       = "kured"
  max_history = "3"
  namespace   = "kured-system"
  version     = "2.2.0"

  values = [<<EOF
extraArgs:
  time-zone: Africa/Johannesburg
  start-time: 00:00
  end-time: 05:00
image:
  tag: 1.5.0
resources:
  limits:
    cpu: 20m
  requests:
    cpu: 5m
EOF
  ]

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "kubernetes_namespace" "cert-manager-system" {
  metadata {
    name = "cert-manager-system"
  }
}

resource "helm_release" "cert-manager" {
  name        = "cert-manager"
  repository  = "https://charts.jetstack.io"
  chart       = "cert-manager"
  max_history = "3"
  namespace   = "cert-manager-system"
  version     = "0.16.1"

  values = [<<EOF
installCRDs: true
nodeSelector:
  "beta\.kubernetes\.io/os": linux
resources:
  limits:
    cpu: 20m
  requests:
    cpu: 5m
EOF
  ]

  depends_on = [azurerm_kubernetes_cluster.this]
}

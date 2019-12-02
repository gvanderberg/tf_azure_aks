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

resource "kubernetes_service_account" "this" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  automount_service_account_token = true

  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "kubernetes_cluster_role_binding" "this" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    api_group = ""
    namespace = "kube-system"
  }

  depends_on = [kubernetes_service_account.this]
}

# Add Kubernetes Stable Helm charts repo
data "helm_repository" "this" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

# Install Nginx Ingress using Helm Chart
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.this.metadata.0.name
  chart      = "nginx-ingress"
  namespace  = "kube-system"

  set {
    name  = "controller.image.tag"
    value = "0.25.0"
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

  depends_on = [kubernetes_service_account.this]
}

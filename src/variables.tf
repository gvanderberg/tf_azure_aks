# -------------------------------------------

variable "client_id" {
  default = "__client_id__"
}

variable "client_secret" {
  default = "__client_secret__"
}

variable "subscription_id" {
  default = "__subscription_id__"
}

variable "tenant_id" {
  default = "9218c3db-1cca-48b1-8f6b-a95a47b58158"
}

# -------------------------------------------

variable "cluster_name" {
  default = "__cluster_name__"
}

variable "dns_service_ip" {
  default = "__dns_service_ip__"
}

variable "docker_bridge_cidr" {
  default = "__docker_bridge_cidr__"
}

variable "kubernetes_dashboard_enabled" {
  default = "__kubernetes_dashboard_enabled__"
}

variable "kubernetes_version" {
  default = "__kubernetes_version__"
}

variable "load_balancer_ip" {
  default = "__load_balancer_ip__"
}

variable "load_balancer_sku" {
  default = "__load_balancer_sku__"
}

variable "location" {
  default = "__location__"
}

variable "log_analytics_workspace_name" {
  default = "__log_analytics_workspace_name__"
}

variable "log_analytics_workspace_sku" {
  default = "__log_analytics_workspace_sku__"
}

variable "node_count" {
  default = "__node_count__"
}

variable "resource_group_name" {
  default = "__resource_group_name__"
}

variable "service_cidr" {
  default = "__service_cidr__"
}

variable "subnet_name" {
  default = "__subnet_name__"
}

variable "network_name" {
  default = "__network_name__"
}

variable "vm_size" {
  default = "__vm_size__"
}

variable "tags" {
  default = {
    costCentre  = "IT Dev"
    createdBy   = "Terraform"
    environment = "__tags_environment__"
    location    = "__tags_location__"
    managedBy   = "__tags_managed_by__"
  }
}

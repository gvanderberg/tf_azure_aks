variable "aad_client_app_id" {
  default = "__aad_client_app_id__"
}

variable "aad_server_app_id" {
  default = "__aad_server_app_id__"
}

variable "aad_server_app_secret" {
  default = "__aad_server_app_secret__"
}

variable "aad_tenant_id" {
  default = "__aad_tenant_id__"
}

variable "admin_password" {
  default = "__admin_password__"
}

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

variable "ssh_key_data" {
  default = "__ssh_key_data__"
}

variable "subnet_name" {
  default = "__subnet_name__"
}

variable "subnet_virtual_network_name" {
  default = "__subnet_virtual_network_name__"
}

variable "subnet_resource_group_name" {
  default = "__subnet_resource_group_name__"
}

variable "virtual_machine_size" {
  default = "__virtual_machine_size__"
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

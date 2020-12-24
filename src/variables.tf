variable "admin_password" {
  default = "__admin_password__"
}

variable "analytics_workspace_name" {
  default = "__analytics_workspace_name__"
}

variable "analytics_workspace_sku" {
  default = "__analytics_workspace_sku__"
}

variable "container_registry_id" {
  default = "__container_registry_id__"
}

variable "dns_service_ip" {
  default = "__dns_service_ip__"
}

variable "docker_bridge_cidr" {
  default = "__docker_bridge_cidr__"
}

variable "docker_config_json" {
  default = "__docker_config_json__"
}

variable "kubernetes_cluster_name" {
  default = "__kubernetes_cluster_name__"
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

variable "node_count" {
  default = "__node_count__"
}

variable "resource_group_create" {
  default = "__resource_group_create__"
}

variable "resource_group_name" {
  default = "__resource_group_name__"
}

variable "service_cidr" {
  default = "__service_cidr__"
}

variable "slack_username" {
  default = "__slack_username__"
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

variable "support_email_address" {
  default = "__support_email_address__"
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

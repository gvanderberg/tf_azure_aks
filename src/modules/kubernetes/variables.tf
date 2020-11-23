variable "admin_username" {
  description = "The Admin Username for the Cluster."
  type        = string
}

variable "admin_password" {
  description = "The Admin Password for the Cluster."
  type        = string
}

variable "container_registry_id" {
  description = "The ID of the Container Registry."
  type        = string
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
  type        = string
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes."
  type        = string
}

variable "docker_config_json" {
  description = "The base64 representation of your Docker credentials."
  type        = string
}

variable "kubernetes_cluster_name" {
  description = "The name of the Managed Kubernetes Cluster to create."
  type        = string
}

variable "kubernetes_dashboard_enabled" {
  description = "Is the Kubernetes Dashboard enabled?"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster."
  type        = string
}

variable "load_balancer_ip" {
  description = "Specifies the IP address of the Load Balancer used for this Kubernetes Cluster."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace which the OMS Agent should send data to."
  type        = string
}

variable "node_count" {
  description = "Number of Agents (VMs) in the Pool. Possible values must be in the range of 1 to 100 (inclusive)."
  type        = string
}

variable "resource_group_location" {
  description = "The location where the Managed Kubernetes Cluster should be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist."
  type        = string
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service."
  type        = string
}

variable "slack_username" {
  description = "Slack Username."
  type        = string
}

variable "ssh_key_data" {
  description = "The Public SSH Key used to access the cluster."
  type        = string
}

variable "subnet_name" {
  description = "Specifies the name of the Subnet."
  type        = string
}

variable "subnet_virtual_network_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within."
  type        = string
}

variable "subnet_resource_group_name" {
  description = "Specifies the name of the resource group the Virtual Network is located in."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map
}

variable "vm_size" {
  description = "The size of each VM in the Agent Pool (e.g. Standard_F1)."
  type        = string
}

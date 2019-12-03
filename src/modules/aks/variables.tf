variable "name" {
  description = "The name of the Managed Kubernetes Cluster to create."
  type        = string
}

variable "aad_client_app_id" {
  description = "The Client ID of an Azure Active Directory Application"
  type        = string
}

variable "aad_server_app_id" {
  description = "The Server ID of an Azure Active Directory Application."
  type        = string
}

variable "aad_server_app_secret" {
  description = "The Server Secret of an Azure Active Directory Application."
  type        = string
}

variable "aad_tenant_id" {
  description = "The Tenant ID used for Azure Active Directory Application."
  type        = string
}

variable "client_id" {
  description = "The Client ID for the Service Principal."
  type        = string
}

variable "client_secret" {
  description = "The Client Secret for the Service Principal."
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

variable "kubernetes_dashboard_enabled" {
  description = "Is the Kubernetes Dashboard enabled?"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster."
  type        = string
}

variable "load_balancer_ip" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster."
  type        = string
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster."
  type        = string
}

variable "location" {
  description = "The location where the Managed Kubernetes Cluster should be created."
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

variable "resource_group_name" {
  description = "Specifies the Resource Group where the Managed Kubernetes Cluster should exist."
  type        = string
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service."
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

variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist."
  type        = string
}

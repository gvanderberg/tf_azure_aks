variable "analytics_workspace_name" {
  description = "Specifies the name of the Log Analytics Workspace."
  type        = string
}

variable "analytics_workspace_sku" {
  description = "Specifies the Sku of the Log Analytics Workspace."
  type        = string
}

variable "resource_group_location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Log Analytics workspace is created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map
}

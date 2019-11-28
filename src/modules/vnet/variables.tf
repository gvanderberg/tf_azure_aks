variable "location" {
  description = "The location/region where the virtual network is created."
  type        = string
}

variable "network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map
}

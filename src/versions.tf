terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2"
    }
  }
  required_version = ">= 0.14"
}

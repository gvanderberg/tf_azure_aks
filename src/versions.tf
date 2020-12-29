terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>1.0"
    }
  }
  required_version = ">= 0.14"
}

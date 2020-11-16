terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~>0.11.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.30.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>1.3.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>1.13.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>2.3.0"
    }
  }
  required_version = ">= 0.13"
}

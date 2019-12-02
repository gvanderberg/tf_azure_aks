provider "azuread" {
  version = "=0.7.0"

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azurerm" {
  version = "=1.37.0"

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# provider "helm" {
#   version         = "=0.10.4"
#   install_tiller  = true
#   namespace       = "kube-system"
#   service_account = "tiller"

#   kubernetes {
#     host                   = module.aks.host
#     client_certificate     = base64decode(module.aks.client_certificate)
#     client_key             = base64decode(module.aks.client_key)
#     cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
#   }
# }

# provider "kubernetes" {
#   version                = "=1.10"
#   host                   = module.aks.host
#   client_certificate     = base64decode(module.aks.client_certificate)
#   client_key             = base64decode(module.aks.client_key)
#   cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
# }

provider "random" {
  version = "=2.1.2"
}

# terraform {
#   backend "remote" {
#     hostname     = "app.terraform.io"
#     organization = "outsurance"
#     token        = "__token__"

#     workspaces {
#       # name = "__workspace_name__"
#       prefix = "personal_aks-"
#     }
#   }
# }

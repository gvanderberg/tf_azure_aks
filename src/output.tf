output "client_key" {
  value = module.aks.client_key
}

output "client_certificate" {
  value = module.aks.client_certificate
}

output "cluster_ca_certificate" {
  value = module.aks.cluster_ca_certificate
}

output "cluster_username" {
  value = module.aks.cluster_username
}

output "cluster_password" {
  value = module.aks.cluster_password
}

output "kube_config" {
  value = module.aks.kube_config
}

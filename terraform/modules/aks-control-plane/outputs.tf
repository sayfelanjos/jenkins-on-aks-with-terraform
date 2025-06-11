output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate
#   sensitive = true
# }
#
# output "kube_config" {
#   value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
#   sensitive = true
# }

output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}
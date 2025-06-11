resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
  count                 = length(var.availability_zones)
  name                  = var.node_pool_name
  kubernetes_cluster_id = var.aks_cluster_id
  vm_size               = var.vm_size
  node_count            = var.node_count
  zones                 = var.availability_zones
  mode                  = "User"
  os_type               = var.os_type
  orchestrator_version  = var.orchestrator_version
  auto_scaling_enabled  = var.auto_scaling_enabled
  min_count             = var.min_count
  max_count             = var.max_count
  vnet_subnet_id        = var.vnet_subnet_ids[0]


  tags = var.common_tags

  lifecycle {
    ignore_changes = [
      zones,
      node_count,
      min_count,
      max_count,
    ]
  }
}
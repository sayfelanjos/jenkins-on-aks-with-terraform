module "workers" {
  source               = "../aks-worker-nodes"
  aks_cluster_id       = var.aks_cluster_id
  auto_scaling_enabled = var.auto_scaling_enabled
  availability_zones   = var.availability_zones
  vnet_subnet_ids       = var.vnet_subnet_ids
  max_count            = var.max_count
  min_count            = var.min_count
  node_count           = var.node_count
  node_pool_name       = var.node_pool_name
  orchestrator_version = var.orchestrator_version
  os_type              = var.os_type
  vm_size              = var.vm_size
  common_tags          = var.common_tags
}
data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "jenkins-aks-cluster-tf-state-rg"
    storage_account_name = "jenkinstfstatestorage"
    container_name       = "jenkins-aks-vnet-tf-state-container"
    key                  = "terraform.tfstate"
  }
}

module "aks" {
  source                          = "../modules/aks-cluster"
  aks_cluster_id                  = module.aks.cluster_id
  auto_scaling_enabled            = var.auto_scaling_enabled
  availability_zones              = var.availability_zones
  azure_location                  = var.azure_location
  name_prefix                     = var.name_prefix
  cluster_version                 = var.cluster_version
  node_resource_group_name        = var.node_resource_group_name
  common_tags                     = var.common_tags
  max_count                       = var.max_count
  min_count                       = var.min_count
  node_count                      = var.node_count
  node_pool_name                  = var.node_pool_name
  orchestrator_version            = var.orchestrator_version
  os_type                         = var.os_type
  resource_group_name             = var.resource_group_name
  service_principal_client_id     = var.service_principal_client_id
  service_principal_client_secret = var.service_principal_client_secret
  vm_size                         = var.vm_size
  vnet_subnet_ids                 = data.terraform_remote_state.vnet.outputs.private_subnet_ids
}
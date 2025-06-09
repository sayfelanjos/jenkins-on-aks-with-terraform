module "aks" {
  source                          = "../aks-control-plane"
  name_prefix                     = var.name_prefix
  resource_group_name             = var.resource_group_name
  azure_location                  = var.azure_location
  cluster_version                 = var.cluster_version
  service_principal_client_id     = var.service_principal_client_id
  availability_zones              = var.availability_zones
  service_principal_client_secret = var.service_principal_client_secret
  common_tags                     = var.common_tags
  vnet_subnet_ids                 = var.vnet_subnet_ids
  node_resource_group             = var.node_resource_group
}
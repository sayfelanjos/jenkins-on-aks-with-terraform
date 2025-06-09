locals {
  common_tags = {
    managed_by = "Terraform"
  }
}

module "vnet" {
  source                          = "../modules/aks-vnet"
  resource_group_name             = var.resource_group_name
  azure_location                  = var.azure_location
  name_prefix                     = var.name_prefix
  aks_vnet_address_space          = var.aks_vnet_address_space
  aks_public_subnets_prefix_list  = var.aks_public_subnets_prefix_list
  aks_private_subnets_prefix_list = var.aks_private_subnets_prefix_list
}
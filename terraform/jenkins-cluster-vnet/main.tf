locals {
  common_tags = {
    managed_by = "Terraform"
  }
}

module "vnet" {
  source                          = "../modules/aks-vnet"
  azure_region                    = var.azure_location
  clusters_name_prefix            = var.clusters_name_prefix
  aks_vnet_address_space          = var.aks_vnet_address_space
  aks_public_subnets_prefix_list  = var.aks_public_subnets_prefix_list
  aks_private_subnets_prefix_list = var.aks_private_subnets_prefix_list
}
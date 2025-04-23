resource "azurerm_resource_group" "jenkins_aks_cluster_rg" {
  name     = "${var.clusters_name_prefix}-aks-cluster-rg"
  location = var.azure_location
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.clusters_name_prefix}-aks-cluster-vnet"
  location            = var.azure_location
  resource_group_name = azurerm_resource_group.jenkins_aks_cluster_rg.name
  address_space       = var.aks_vnet_address_space
}

resource "azurerm_subnet" "aks_public_subnet" {
  count                = length(var.aks_public_subnets_prefix_list)
  name                 = "${var.clusters_name_prefix}-aks-public-subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.jenkins_aks_cluster_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.aks_public_subnets_prefix_list[count.index]]
}

resource "azurerm_subnet" "aks_private_subnet" {
  count                = length(var.aks_private_subnets_prefix_list)
  name                 = "${var.clusters_name_prefix}-aks-private-subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.jenkins_aks_cluster_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [var.aks_private_subnets_prefix_list[count.index]]
}
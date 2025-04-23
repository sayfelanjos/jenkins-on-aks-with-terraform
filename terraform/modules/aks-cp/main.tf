resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${var.clusters_name_prefix}-aks-cluster"
  location            = var.azure_location
  kubernetes_version  = var.cluster_version
  resource_group_name = var.resource_group_name
  sku_tier            = "Standard"

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
  }

  tags = var.common_tags
}
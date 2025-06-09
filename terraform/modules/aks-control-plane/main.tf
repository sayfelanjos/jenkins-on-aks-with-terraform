data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "jenkins-aks-cluster-tf-state-rg"
    storage_account_name = "jenkinstfstatestorage"
    container_name       = "jenkins-aks-vnet-tf-state-container"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                    = "${var.name_prefix}-aks-cluster"
  location                = var.azure_location
  kubernetes_version      = var.cluster_version
  resource_group_name     = var.resource_group_name
  sku_tier                = "Standard"
  node_os_upgrade_channel = "NodeImage"
  dns_prefix              = var.name_prefix
  node_resource_group     = var.node_resource_group


  # service_principal {
  #   client_id     = var.service_principal_client_id
  #   client_secret = var.service_principal_client_secret
  # }

  identity {
    type = "SystemAssigned"
  }


  default_node_pool {
    name                         = "systempool"
    scale_down_mode              = "system"
    temporary_name_for_rotation  = "temppool"
    zones                        = var.availability_zones
    node_count                   = 3
    vm_size                      = "Standard_D2s_v3"
    type                         = "VirtualMachineScaleSets"
    only_critical_addons_enabled = true
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    load_balancer_sku = "standard"
  }



  tags = var.common_tags
}
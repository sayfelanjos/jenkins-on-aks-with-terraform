resource "azurerm_resource_group" "jenkins_tf_state_rg" {
  name     = "${var.name_prefix}-aks-cluster-tf-state-rg"
  location = var.azure_region
}

resource "azurerm_storage_account" "jenkins_tf_state_storage_account" {
  name                              = "${var.name_prefix}tfstatestorage"
  resource_group_name               = azurerm_resource_group.jenkins_tf_state_rg.name
  location                          = azurerm_resource_group.jenkins_tf_state_rg.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  infrastructure_encryption_enabled = "true"
}

resource "azurerm_storage_container" "clusters_tf_state_container" {
  name                  = "${var.name_prefix}-aks-cluster-tf-state-container"
  storage_account_id    = azurerm_storage_account.jenkins_tf_state_storage_account.id
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.jenkins_tf_state_storage_account]
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "vnet_tf_state_container" {
  name                  = "${var.name_prefix}-aks-vnet-tf-state-container"
  storage_account_id    = azurerm_storage_account.jenkins_tf_state_storage_account.id
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.jenkins_tf_state_storage_account]
  lifecycle {
    prevent_destroy = true
  }
}
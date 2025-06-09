output "aks_vnet_id" {
  value = azurerm_virtual_network.aks_vnet[*].id
}
output "aks_public_subnet_id" {
  value = azurerm_subnet.aks_public_subnet[*].id
}
output "aks_private_subnet_id" {
  value = azurerm_subnet.aks_private_subnet[*].id
}
output "aks_vnet_details" {
  value = azurerm_virtual_network.aks_vnet
}

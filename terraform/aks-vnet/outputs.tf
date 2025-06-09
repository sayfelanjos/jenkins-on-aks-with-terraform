output "vnet_id" {
  value = module.vnet.aks_vnet_id
}
output "public_subnet_ids" {
  value = module.vnet.aks_public_subnet_id
}
output "private_subnet_ids" {
  value = module.vnet.aks_private_subnet_id
}
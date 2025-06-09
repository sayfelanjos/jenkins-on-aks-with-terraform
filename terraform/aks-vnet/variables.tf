variable "resource_group_name" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "azure_location" {
  type = string
}
variable "aks_vnet_address_space" {
  type = list(string)
}
variable "aks_public_subnets_prefix_list" {
  type = list(string)
}
variable "aks_private_subnets_prefix_list" {
  type = list(string)
}
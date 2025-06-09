variable "resource_group_name" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "azure_location" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
variable "common_tags" {
  type = map(string)
}
variable "service_principal_client_id" {
  type = string
}
variable "service_principal_client_secret" {
  type = string
}
variable "vnet_subnet_ids" {
  type = list(string)
}
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
variable "common_tags" {
  type = map(string)
}
variable "service_principal_client_id" {
  type = string
}
variable "service_principal_client_secret" {
  type = string
}
variable "orchestrator_version" {
  type = string
}
variable "node_pool_name" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "node_count" {
  type = number
}
variable "min_count" {
  type = number
}
variable "max_count" {
  type = number
}
variable "auto_scaling_enabled" {
  type = bool
}
variable "availability_zones" {
  type = list(string)
}
variable "os_type" {
  type = string
}
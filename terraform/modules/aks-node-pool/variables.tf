variable "orchestrator_version" {
  type = string
}
variable "node_pool_name" {
  type = list(string)
}
variable "aks_cluster_id" {
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
variable "common_tags" {
  type = map(string)
}
variable "os_type" {
  type = string
}
variable "vnet_subnet_id" {
    type = list(string)
}
variable "azure_region" {
  description = "The Azure region to deploy the shared state storage account."
  type        = string
}

variable "clusters_name_prefix" {
  description = "The prefix for the cluster names."
  type        = string
}
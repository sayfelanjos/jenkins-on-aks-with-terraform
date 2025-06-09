variable "azure_region" {
  description = "The Azure region to deploy the shared state storage account."
  type        = string
}

variable "name_prefix" {
  description = "The prefix for the cluster resource names."
  type        = string
}
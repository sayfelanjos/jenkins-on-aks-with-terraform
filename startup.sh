#!/usr/bin/env bash

NAME_PREFIX="jenkins"
RESOURCE_GROUP_NAME="$NAME_PREFIX-aks-cluster-rg"
LOCATION="westus2"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create a virtual network
terraform -chdir="./terraform/aks-cluster" fmt -recursive &&
terraform -chdir="./terraform/aks-cluster" init &&
terraform -chdir="./terraform/aks-vnet" apply -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX"

# Create an AKS cluster
terraform -chdir="./terraform/aks-cluster" fmt -recursive &&
terraform -chdir="./terraform/aks-cluster" init &&
terraform -chdir="./terraform/aks-cluster" apply -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX"
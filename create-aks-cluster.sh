#!/usr/bin/env bash

NAME_PREFIX="jenkins"
RESOURCE_GROUP_NAME="$NAME_PREFIX-aks-cluster-rg"
NODE_RESOURCE_GROUP_NAME="$NAME_PREFIX-aks-cluster-node-pool-rg"
LOCATION="WestUS2"

# Create a resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Format Terraform files
terraform fmt -recursive

# Create a virtual network
terraform -chdir="./terraform/aks-vnet" init &&
terraform -chdir="./terraform/aks-vnet" apply -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" &&

# Create an AKS cluster
terraform -chdir="./terraform/aks-cluster" init &&
terraform -chdir="./terraform/aks-cluster" apply -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" \
  -var "node_resource_group_name=$NODE_RESOURCE_GROUP_NAME" &&

# Get AKS credentials
CLUSTER_NAME=$(terraform -chdir="./terraform/aks-cluster" output -raw cluster_name) &&
az aks get-credentials -g $RESOURCE_GROUP_NAME -n "$CLUSTER_NAME" --overwrite-existing &&

# Setup Jenkins
bash "./install-jenkins.sh"
bash "./install-sonarqube.sh"
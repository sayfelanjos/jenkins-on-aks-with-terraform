#!/usr/bin/env bash

NAME_PREFIX="jenkins"
RESOURCE_GROUP_NAME="$NAME_PREFIX-aks-cluster-rg"
NODE_RESOURCE_GROUP_NAME="$NAME_PREFIX-aks-cluster-node-pool-rg"
LOCATION="WestUS2"

# Remove the Jenkins Ingress resource
helm uninstall ingress-nginx-jenkins --namespace jenkins
#echo "Jenkins Ingress resource removed."

# Remove the Jenkins Helm release
helm uninstall myjenkins -n jenkins --namespace jenkins
#echo "Jenkins Helm release removed."

# Remove the SonarQube Ingress resource
helm uninstall ingress-nginx-sonarqube --namespace sonarqube
#echo "SonarQube Ingress resource removed."

# Remove the SonarQube Helm release
helm uninstall sonarqube -n sonarqube --namespace sonarqube
#echo "SonarQube Helm release removed."

# Remove the Artifactory Ingress resource
helm uninstall ingress-nginx-artifactory --namespace artifactory

# Remove the Artifactory Helm release
helm uninstall artifactory -n artifactory --namespace artifactory


# Destroy the AKS cluster
terraform -chdir="./terraform/aks-cluster" refresh \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" \
  -var "node_resource_group_name=$NODE_RESOURCE_GROUP_NAME" &&
  echo "AKS cluster resources refreshed." &&

terraform -chdir="./terraform/aks-cluster" destroy -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" \
  -var "node_resource_group_name=$NODE_RESOURCE_GROUP_NAME" &&
  echo "AKS cluster resources destroyed." &&

# Destroy the virtual network
terraform -chdir="./terraform/aks-vnet" refresh \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" &&
  echo "Virtual network resources refreshed." &&

terraform -chdir="./terraform/aks-vnet" destroy -auto-approve \
  -var "resource_group_name=$RESOURCE_GROUP_NAME" \
  -var "azure_location=$LOCATION" \
  -var "name_prefix=$NAME_PREFIX" &&
  echo "Virtual network resources destroyed." &&

# Delete the resource group
az group delete --yes --name $RESOURCE_GROUP_NAME
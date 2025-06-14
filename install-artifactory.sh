#!/usr/bin/env bash

# This script sets up the JFrog Artifactory server on an Azure Kubernetes Service (AKS) cluster.

# Add Ingress-Nginx repository as a source of Helm Charts and update the repositories
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install Nginx Ingress Controller for Artifactory
helm install ingress-nginx-artifactory ingress-nginx/ingress-nginx \
 --create-namespace -n artifactory \
 --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
 --set controller.replicaCount=1 \
 --set controller.ingressClassResource.name=artifactory-nginx \
 --set controller.ingressClassResource.controllerValue=k8s.io/artifactory-nginx

# Add the JFrog Artifactory Helm Chart repository
helm repo add jfrog https://charts.jfrog.io
helm repo update

# Install JFrog Artifactory using Helm
helm upgrade --install artifactory \
 --set artifactory.nginx.enabled=false \
 --set artifactory.ingress.enabled=false \
 -n artifactory \
 jfrog/artifactory

# Create an Ingress resource for Artifactory
 kubectl apply -f ./artifactory-ingress.yaml -n artifactory
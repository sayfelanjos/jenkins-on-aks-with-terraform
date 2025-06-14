#!/usr/bin/env bash

# This script sets up the SonarQube server on an Azure Kubernetes Service (AKS) cluster.

# Add Ingress-Nginx repository as a source of Helm Charts and update the repositories
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Install Nginx Ingress Controller for SonarQube
helm install ingress-nginx-sonarqube ingress-nginx/ingress-nginx \
 --create-namespace -n sonarqube \
 --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
 --set controller.replicaCount=1 \
 --set controller.ingressClassResource.name=sonarqube-nginx \
 --set controller.ingressClassResource.controllerValue=k8s.io/sonarqube-nginx

# Add the SonarQube Helm Chart repository
helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update

# Install SonarQube using Helm
export MONITORING_PASSCODE="yourPasscode"
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --set edition=developer,monitoringPasscode=$MONITORING_PASSCODE

# Create an Ingress resource for SonarQube
kubectl apply -f ./sonarqube-ingress.yaml -n sonarqube
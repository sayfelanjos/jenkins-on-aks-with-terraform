# Terraform Azure Kubernetes Service (AKS) Jenkins and SonarQube Setup

This project provides Terraform scripts and shell scripts to automate the deployment of a Jenkins and SonarQube environment on Azure Kubernetes Service (AKS).

## Prerequisites

Before you begin, ensure you have the following installed and configured:

*   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
*   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
*   [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
*   An active Azure subscription

## Project Structure

The project is organized as follows:

*   `terraform/`: Contains the Terraform configurations for the AKS cluster and related resources.
    *   `modules/`: Contains reusable Terraform modules.
    *   `aks-vnet/`: Terraform configuration for the virtual network.
    *   `aks-cluster/`: Terraform configuration for the AKS cluster.
    *   `shared-state/`: Terraform configuration for the remote state storage.
*   `*.sh`: Shell scripts for installing and configuring various components like Jenkins, SonarQube, Artifactory, etc.
*   `*.yaml`: Kubernetes manifest files for ingress controllers.

## Deployment Steps

1.  **Initialize Terraform:**
    Navigate to the `terraform` directory and run `terraform init` to initialize the backend and providers.

2.  **Create the AKS Cluster:**
    Run the `create-aks-cluster.sh` script to create the AKS cluster. This script will also configure the `kubectl` context.

3.  **Install Jenkins:**
    Run the `install-jenkins.sh` script to install Jenkins on the AKS cluster.

4.  **Install SonarQube:**
    Run the `install-sonarqube.sh` script to install SonarQube on the AKS cluster.

5.  **Install Artifactory:**
    Run the `install-artifactory.sh` script to install Artifactory on the AKS cluster.

6.  **Install Jenkins Plugins:**
    Run the `install-jenkins-plugins.sh` script to install necessary Jenkins plugins.

## Accessing the Services

*   **Jenkins:** Access the Jenkins dashboard using the URL provided by the ingress
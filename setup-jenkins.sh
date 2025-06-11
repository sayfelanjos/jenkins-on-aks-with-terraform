#!/usr/bin/env bash

# This script sets up Jenkins on an Azure Kubernetes Service (AKS) cluster.

# Add the ingress-nginx repository as a source of Helm Charts
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx &&
# Add the Jenkins Helm Chart repository
helm repo add jenkins https://charts.jenkins.io &&

# Update Helm repositories to ensure the latest charts are available
helm repo update &&

# Install the ingress-nginx controller using Helm
helm install ingress-nginx-jenkins ingress-nginx/ingress-nginx \
 --create-namespace -n jenkins \
 --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
 --set controller.replicaCount=1 \
 --set controller.ingressClassResource.name=jenkins-nginx \
 --set controller.ingressClassResource.controllerValue=k8s.io/jenkins-nginx &&


# Install Jenkins using Helm

CLUSTER_IP=$(kubectl get service/ingress-nginx-jenkins-controller -n jenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}') &&

cat <<EOF | helm install -f - -n jenkins myjenkins jenkins/jenkins &&
controller:
  jenkinsUrl: $CLUSTER_IP
  JCasC:
    configScripts:
      welcome-message: |
        jenkins:
          systemMessage: Welcome to our Continuous Integration server.
EOF

# Create an Ingress resource for Jenkins
kubectl apply -f ./jenkins-ingress.yaml -n jenkins &&

echo "Jenkins has been successfully installed and configured."
echo "You can access Jenkins at http://$CLUSTER_IP"

# To access Jenkins, you can use the following command to get the admin password:
echo "Username: admin"

# TODO: It necessary to check the container status before executing the command
Password=$(kubectl exec --namespace jenkins \
 -it svc/myjenkins -c jenkins \
 -- /bin/cat /run/secrets/additional/chart-admin-password)

echo "Password: $Password"
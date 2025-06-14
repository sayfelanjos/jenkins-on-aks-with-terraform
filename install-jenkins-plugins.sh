#!/usr/bin/env bash

JENKINS_INSTANCE_NAME="myjenkins"
JENKINS_IP=$(kubectl get service/ingress-nginx-jenkins-controller -n jenkins -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
JENKINS_URL="http://$JENKINS_IP"
JENKINS_USER_ID="admin"
JENKINS_API_TOKEN="$(kubectl exec --namespace jenkins -it svc/$JENKINS_INSTANCE_NAME -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password)"
export JENKINS_URL
export JENKINS_USER_ID
export JENKINS_API_TOKEN

# Install Jenkins plugins
java -jar ./jenkins-cli.jar install-plugin github:1.43.0
java -jar ./jenkins-cli.jar install-plugin sonar:2.18
java -jar ./jenkins-cli.jar install-plugin artifactory:4.0.8
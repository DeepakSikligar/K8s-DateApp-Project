#!/bin/bash

echo "*****************  Please wait for sometime while we Setup your env ******************************"
echo " ---->> Lets get inside your minikube and Set Minikube in-cluster Docker daemon"

eval $(minikube docker-env)


echo "---->>  Step1. Build docker image "
docker build -t date-time-app .

echo " ---->>  Lets create Persistent Volumes and Persistent Volume Claim"
## Lets create Persistent Volumes and Persistent Volume Claim
kubectl apply -f K8s/PVs/pv-date.yaml
kubectl apply -f K8s/PVs/pvc-date.yaml

echo " ---->>  Now lets create a cron job that runs every minute and print current date and time to location /data/storgae.txt"
## Now lets create a cron job that runs every minute and print current date and time to location "/data/storgae.txt"
kubectl apply -f K8s/Jobs/with-pv-job-date.yaml

echo " ---->> Lets create a deployment "
## Lets create a deployment
kubectl apply -f K8s/Deployments/with-pv-deploy-date.yaml

echo " ---->>  Once the deployment is ready, lets create nodeport service endpoint available to CURL against so that end users can read a list of the last 5 job outputs returned as JSON."
## Once the deployment is ready, lets create nodeport service endpoint available to CURL against so that end users can read a list of the last 5 job outputs returned as JSON.
kubectl apply -f K8s/Services/svc-date.yaml

echo " ---->> Get minikube IP, we will use this IP to form CURL url"
## Get minikube IP, we will use this IP to form CURL url:
echo "$(minikube ip)"
### take the output from the above minikube IP command and replace this with output-of-minikube-ip under below curl url

echo " ---->> Lets form the CURL command to return last 5 job output"
## CURL command to return last 5 job output
port=31222

echo " ---->> here you go..... "
echo " Please copy this below curl URL and Hit the terminal to see the results:"
echo "NOTE: Please wait for atleast 5 minutes to have some datetime entries in the file before you hit curl"
echo "curl --location --request GET 'http://$(minikube ip):$port/date'"
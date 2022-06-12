#!/bin/bash

#######
# Make sure you are connected kubeclt context is set to the newly cerated cluster and run then run this script
#######

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace

kubectl --namespace monitoring get pods -l "release=prometheus"

kubectl port-forward --namespace monitoring svc/prometheus-kube-prometheus-prometheus 9090 &

kubectl port-forward --namespace monitoring svc/prometheus-grafana 8080:80 &
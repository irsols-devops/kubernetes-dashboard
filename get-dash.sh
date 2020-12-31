#!/bin/bash
#
# IRSOLS Inc 2019-2021
# Small script to get K8s Dashboard URL and credential token
# This is required for multi-host cluster where K8s can randomly
# assign dashboard pods to any node in the cluster .
# First version : Aug 2019
# Last modified : Dec 2020

export DASH_NODE_NAME=`kubectl get pods  --all-namespaces -o wide | grep "kubernetes-dashboard-" | awk {'print $8'}`
export DASH_NODE_IP=`grep $DASH_NODE_NAME /etc/hosts | awk {'print $1'}`
export DASH_NODE_PORT=` kubectl get services  --all-namespaces -o wide | grep "443:" | awk {'print $6'} | sed  's/443//' | sed 's/\/TCP//'`

echo "Your Dashboard with Nodeport URL is: https://$DASH_NODE_IP$DASH_NODE_PORT/"
echo
echo
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')


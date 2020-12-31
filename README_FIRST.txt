IRSOLS Inc 2019-2021
Last Modified : Dec 28.2020
---------------------------------------------------------
Kubernetes Dashboard Configuration Steps :(With NodePort)
---------------------------------------------------------
Steps to deploy the K8s dashboard with NodePort
Download the official/recommended K8s dashboard yaml file and modify it. Modified version
is included in this repo.
1. Create the deployment : kubectl apply -f kubernetes-dashboard-deployment.yml
2. Create service account admin role :  kubectl apply -f service-account-admin.yml
3. Perform cluster role binding : kubectl apply -f rbac-clusterRoleBinding-admin.yml
4. Ensure K8s deployment and service are up and running :
  a. kubectl get deployments -n kubernetes-dashboard
  b. If this is a multi-node cluster then figure out which node the dashboard pods are running on :
	kubectl get pods --namespace=kubernetes-dashboard -o wide
  c. Double check that there are no issues in the services and its not in CrashLoopBack state:
5. Get the NodePort Dashboard is exposed on using following :
    kubectl get services --namespace=kubernetes-dashboard -o wide
6. Get service token and store in a local file using :
   kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

7. Open up a browser that allows self-signed certificate using webpages ( e.g. Firefox ) and use the node  IP:Nodeport combination to access the dashboard . e.g. https://<node4>:<node_port> will be https://10.10.0.4:32005

8. In the login window use the token from previous step

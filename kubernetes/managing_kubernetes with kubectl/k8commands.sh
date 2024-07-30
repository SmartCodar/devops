#!/bin/bash

# Variables for namespaces, pod, and other Kubernetes resources
NAMESPACE="your_namespace"
POD_NAME="your_pod_name"
DEPLOYMENT_NAME="your_deployment_name"
NODE_NAME="your_node_name"
SERVICE_NAME="your_service_name"
CONFIG_MAP_NAME="your_config_map_name"
SECRET_NAME="your_secret_name"
PVC_NAME="your_pvc_name"
PV_NAME="your_pv_name"
CONTAINER_NAME="your_container_name"
MANIFEST_FILE="your_manifest_file.yaml"
COMMAND="your_command"

# List all pods in a namespace
echo "Listing all pods in namespace: $NAMESPACE"
kubectl get pods -n $NAMESPACE

# Describe a specific pod
echo "Describing pod: $POD_NAME"
kubectl describe pod $POD_NAME -n $NAMESPACE

# Check logs of a specific pod
echo "Checking logs for pod: $POD_NAME"
kubectl logs $POD_NAME -n $NAMESPACE

# Get a list of services
echo "Listing all services"
kubectl get svc

# Get a list of deployments
echo "Listing all deployments"
kubectl get deployments

# Describe a specific deployment
echo "Describing deployment: $DEPLOYMENT_NAME"
kubectl describe deployment $DEPLOYMENT_NAME -n $NAMESPACE

# Get a list of nodes
echo "Listing all nodes"
kubectl get nodes

# Describe a specific node
echo "Describing node: $NODE_NAME"
kubectl describe node $NODE_NAME

# Get a list of config maps
echo "Listing all config maps"
kubectl get configmaps -n $NAMESPACE

# Get a list of secrets
echo "Listing all secrets"
kubectl get secrets -n $NAMESPACE

# Get a list of persistent volumes
echo "Listing all persistent volumes"
kubectl get pv

# Get a list of persistent volume claims
echo "Listing all persistent volume claims in namespace: $NAMESPACE"
kubectl get pvc -n $NAMESPACE

# Check the resource usage of nodes
echo "Checking resource usage of all nodes"
kubectl top nodes

# Check the resource usage of pods
echo "Checking resource usage of pods in namespace: $NAMESPACE"
kubectl top pods -n $NAMESPACE

# Execute a command in a container of a pod
echo "Executing command in a container of a pod"
kubectl exec $POD_NAME -n $NAMESPACE -c $CONTAINER_NAME -- $COMMAND

# Apply a deployment from a manifest file
echo "Applying deployment from manifest file: $MANIFEST_FILE"
kubectl apply -f $MANIFEST_FILE

# Delete a deployment
echo "Deleting deployment: $DEPLOYMENT_NAME"
kubectl delete deployment $DEPLOYMENT_NAME -n $NAMESPACE

# Delete a pod
echo "Deleting pod: $POD_NAME"
kubectl delete pod $POD_NAME -n $NAMESPACE

# Scale a deployment
SCALE_NUMBER=3 # Number of replicas
echo "Scaling deployment: $DEPLOYMENT_NAME to $SCALE_NUMBER replicas"
kubectl scale deployment $DEPLOYMENT_NAME --replicas=$SCALE_NUMBER -n $NAMESPACE

# Get the rollout status of a deployment
echo "Checking rollout status for deployment: $DEPLOYMENT_NAME"
kubectl rollout status deployment $DEPLOYMENT_NAME -n $NAMESPACE

# Rollback a deployment
echo "Rolling back deployment: $DEPLOYMENT_NAME"
kubectl rollout undo deployment $DEPLOYMENT_NAME -n $NAMESPACE

# Apply a label to a pod
LABEL="key=value" # Define your label
echo "Applying label to pod: $POD_NAME"
kubectl label pods $POD_NAME $LABEL -n $NAMESPACE

# Display all the events in the namespace
echo "Displaying all events in the namespace: $NAMESPACE"
kubectl get events -n $NAMESPACE

# List all resources in a namespace
echo "Listing all resources in namespace: $NAMESPACE"
kubectl get all -n $NAMESPACE

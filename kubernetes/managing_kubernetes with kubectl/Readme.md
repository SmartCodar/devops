
# Kubernetes Command Reference Guide

This article provides a comprehensive list of essential Kubernetes commands, each accompanied by a detailed explanation and practical examples.

## 1. List All Pods in a Namespace
```bash
NAMESPACE="your_namespace"
kubectl get pods -n $NAMESPACE
```
This command lists all pods within a specified namespace. It’s useful for checking the status and number of pods running in a particular namespace, ensuring your deployments are active and functioning as expected.

## 2. Describe a Specific Pod
```bash
POD_NAME="your_pod_name"
kubectl describe pod $POD_NAME -n $NAMESPACE
```
Describing a pod provides detailed information, including events, configuration, and resource usage. This is invaluable for troubleshooting issues with a specific pod, such as understanding why a pod is in a crash loop.

## 3. Check Logs of a Specific Pod
```bash
POD_NAME="your_pod_name"
kubectl logs $POD_NAME -n $NAMESPACE
```
Fetching logs from a pod helps diagnose issues within the application running in the pod. Logs can reveal runtime errors or unexpected behavior in your application.

## 4. Get a List of Services
```bash
kubectl get svc
```
This command lists all services in the default namespace. Services in Kubernetes are responsible for enabling network access to a set of pods. Use this command to verify service creation and configuration.

## 5. Get a List of Deployments
```bash
kubectl get deployments
```
Retrieving a list of deployments gives an overview of the current state of your applications. Deployments manage the lifecycle of applications, allowing you to roll out updates and scale pods easily.

## 6. Describe a Specific Deployment
```bash
DEPLOYMENT_NAME="your_deployment_name"
kubectl describe deployment $DEPLOYMENT_NAME -n $NAMESPACE
```
Describing a deployment provides in-depth information about the deployment's configuration, current status, and history of events. This is useful for debugging issues related to deployments and rollout status.

## 7. Get a List of Nodes
```bash
kubectl get nodes
```
This command lists all nodes in your Kubernetes cluster. Nodes are the worker machines in Kubernetes, and listing them helps ensure all nodes are registered and ready to accept workloads.

## 8. Describe a Specific Node
```bash
NODE_NAME="your_node_name"
kubectl describe node $NODE_NAME
```
Describing a node gives detailed information about the node's capacity, labels, allocated resources, and any taints. This information is crucial for understanding the health and capacity of your cluster nodes.

## 9. Get a List of Config Maps
```bash
kubectl get configmaps -n $NAMESPACE
```
Listing config maps in a namespace provides an overview of the configuration data available to your applications. Config maps are used to manage application configuration without requiring container image changes.

## 10. Get a List of Secrets
```bash
kubectl get secrets -n $NAMESPACE
```
Secrets store sensitive information such as passwords, OAuth tokens, and SSH keys. Listing secrets helps you manage and audit the sensitive information used by your applications.

## 11. Get a List of Persistent Volumes
```bash
kubectl get pv
```
This command lists all persistent volumes in the cluster. Persistent volumes provide durable storage in Kubernetes, and listing them ensures your storage resources are correctly provisioned and available.

## 12. Get a List of Persistent Volume Claims in a Namespace
```bash
kubectl get pvc -n $NAMESPACE
```
Listing persistent volume claims (PVCs) in a namespace shows the storage requests made by pods. PVCs are used to provision storage dynamically, and this command helps track storage usage.

## 13. Check the Resource Usage of Nodes
```bash
kubectl top nodes
```
The `kubectl top nodes` command displays the current resource usage (CPU and memory) of each node in the cluster. It helps in monitoring and identifying resource bottlenecks at the node level.

## 14. Check the Resource Usage of Pods in a Namespace
```bash
kubectl top pods -n $NAMESPACE
```
Checking the resource usage of pods provides insights into the CPU and memory consumption of each pod. This information is crucial for performance tuning and ensuring efficient resource utilization.

## 15. Execute a Command in a Container of a Pod
```bash
POD_NAME="your_pod_name"
CONTAINER_NAME="your_container_name"
COMMAND="your_command"
kubectl exec $POD_NAME -n $NAMESPACE -c $CONTAINER_NAME -- $COMMAND
```
Executing a command inside a pod’s container is useful for debugging and interacting with the application directly. This can be used to run diagnostic commands or check the state of the application.

## 16. Apply a Deployment from a Manifest File
```bash
MANIFEST_FILE="your_manifest_file.yaml"
kubectl apply -f $MANIFEST_FILE
```
Applying a deployment from a manifest file updates or creates resources defined in the YAML file. This is the primary method for deploying applications and resources in Kubernetes.

## 17. Delete a Deployment
```bash
DEPLOYMENT_NAME="your_deployment_name"
kubectl delete deployment $DEPLOYMENT_NAME -n $NAMESPACE
```
Deleting a deployment removes all associated pods and replicaset resources. This is useful for cleaning up unused resources or removing applications no longer needed.

## 18. Delete a Pod
```bash
POD_NAME="your_pod_name"
kubectl delete pod $POD_NAME -n $NAMESPACE
```
Deleting a pod terminates it, allowing for resource cleanup and testing of pod rescheduling. It’s useful for scenarios where you need to remove malfunctioning pods or scale down manually.

## 19. Scale a Deployment
```bash
DEPLOYMENT_NAME="your_deployment_name"
SCALE_NUMBER=3 # Number of replicas
kubectl scale deployment $DEPLOYMENT_NAME --replicas=$SCALE_NUMBER -n $NAMESPACE
```
Scaling a deployment adjusts the number of pod replicas, enabling horizontal scaling of applications. This ensures your application can handle varying loads by adding or removing pods.

## 20. Get the Rollout Status of a Deployment
```bash
DEPLOYMENT_NAME="your_deployment_name"
kubectl rollout status deployment $DEPLOYMENT_NAME -n $NAMESPACE
```
Checking the rollout status of a deployment provides information on the progress of a deployment update. This is useful for monitoring the state of rolling updates or rollbacks.

## 21. Rollback a Deployment
```bash
DEPLOYMENT_NAME="your_deployment_name"
kubectl rollout undo deployment $DEPLOYMENT_NAME -n $NAMESPACE
```
Rolling back a deployment reverts it to a previous state. This is critical for recovering from failed updates or unexpected issues after a deployment.

## 22. Apply a Label to a Pod
```bash
POD_NAME="your_pod_name"
LABEL="key=value" # Define your label
kubectl label pods $POD_NAME $LABEL -n $NAMESPACE
```
Labeling a pod applies key-value metadata to it, which is useful for organizing and selecting resources using label selectors.

## 23. Display All Events in a Namespace
```bash
kubectl get events -n $NAMESPACE
```
Listing all events in a namespace provides a history of significant occurrences, such as pod scheduling and state changes. This is useful for debugging and understanding the sequence of events leading to an issue.

## 24. List All Resources in a Namespace
```bash
kubectl get all -n $NAMESPACE
```
This command lists all resources (pods, services, deployments, etc.) in a namespace, giving a comprehensive view of all running components. It’s useful for a high-level overview of the namespace state.


### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Node Not Ready in Kubernetes Cluster
---

Node Not Ready in Kubernetes Cluster is an incident type that occurs when a node in a Kubernetes cluster fails to respond, is unresponsive, or is not ready to take on workloads. This can cause disruptions in service and lead to downtime, as the cluster is unable to allocate resources effectively. This incident type can be caused by a range of factors, including hardware issues, network problems, and configuration errors. Swift resolution of this incident is essential to ensure that the Kubernetes cluster is able to function correctly and provide uninterrupted service.

### Parameters
```shell
# Environment Variables

export NODE_NAME="PLACEHOLDER"

export USERNAME="PLACEHOLDER"

```

## Debug

### Get the status of all nodes in the Kubernetes cluster
```shell
kubectl get nodes
```

### Check the events for a specific node to see if there are any error messages
```shell
kubectl describe node ${NODE_NAME}
```

### Check the status of the kubelet process on the node
```shell
sudo systemctl status kubelet
```

### Check the logs for the kubelet process on the node
```shell
sudo journalctl -u kubelet
```

### Check the status of the container runtime on the node
```shell
sudo systemctl status docker 
```

### Check the logs for the container runtime on the node
```shell
sudo journalctl -u docker
```

### Check the status of the Kubernetes control plane components
```shell
kubectl get componentstatuses
```

### Check the status of the Kubernetes scheduler
```shell
kubectl get pods -n kube-system -l component=kube-scheduler
```

### Check the status of the Kubernetes controller manager
```shell
kubectl get pods -n kube-system -l component=kube-controller-manager
```

### Insufficient resources on the Kubernetes node, causing it to become unresponsive.
```shell
bash

#!/bin/bash

# Set the node name

NODE_NAME=${NODE_NAME}

# Get the node's current resource usage

RESOURCE_USAGE=$(kubectl top node $NODE_NAME)

# Get the node's capacity

CAPACITY=$(kubectl describe node $NODE_NAME | grep -E "Allocatable")

# Check if the node is using more resources than it has available

if [[ $RESOURCE_USAGE > $CAPACITY ]]; then

  echo "Node $NODE_NAME is using more resources than it has available."

  echo "Resource usage: $RESOURCE_USAGE"

  echo "Capacity: $CAPACITY"

else

  echo "Node $NODE_NAME has sufficient resources."

fi

```

## Repair

### Restart the kubelet service on the node to make sure it's properly connected to the control plane.
```shell
bash

#!/bin/bash

# Set the node name

NODE_NAME=${NODE_NAME}

# Restart the kubelet service

ssh ${USERNAME}@$NODE_NAME "systemctl restart kubelet"

```
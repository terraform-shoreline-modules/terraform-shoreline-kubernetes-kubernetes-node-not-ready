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
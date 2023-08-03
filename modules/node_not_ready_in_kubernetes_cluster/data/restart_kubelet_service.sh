bash

#!/bin/bash

# Set the node name

NODE_NAME=${NODE_NAME}

# Restart the kubelet service

ssh ${USERNAME}@$NODE_NAME "systemctl restart kubelet"
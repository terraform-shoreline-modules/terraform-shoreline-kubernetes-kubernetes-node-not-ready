resource "shoreline_notebook" "node_not_ready_in_kubernetes_cluster" {
  name       = "node_not_ready_in_kubernetes_cluster"
  data       = file("${path.module}/data/node_not_ready_in_kubernetes_cluster.json")
  depends_on = [shoreline_action.invoke_node_resource_check,shoreline_action.invoke_restart_kubelet_service]
}

resource "shoreline_file" "node_resource_check" {
  name             = "node_resource_check"
  input_file       = "${path.module}/data/node_resource_check.sh"
  md5              = filemd5("${path.module}/data/node_resource_check.sh")
  description      = "Insufficient resources on the Kubernetes node, causing it to become unresponsive."
  destination_path = "/agent/scripts/node_resource_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "restart_kubelet_service" {
  name             = "restart_kubelet_service"
  input_file       = "${path.module}/data/restart_kubelet_service.sh"
  md5              = filemd5("${path.module}/data/restart_kubelet_service.sh")
  description      = "Restart the kubelet service on the node to make sure it's properly connected to the control plane."
  destination_path = "/agent/scripts/restart_kubelet_service.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_node_resource_check" {
  name        = "invoke_node_resource_check"
  description = "Insufficient resources on the Kubernetes node, causing it to become unresponsive."
  command     = "`chmod +x /agent/scripts/node_resource_check.sh && /agent/scripts/node_resource_check.sh`"
  params      = ["NODE_NAME"]
  file_deps   = ["node_resource_check"]
  enabled     = true
  depends_on  = [shoreline_file.node_resource_check]
}

resource "shoreline_action" "invoke_restart_kubelet_service" {
  name        = "invoke_restart_kubelet_service"
  description = "Restart the kubelet service on the node to make sure it's properly connected to the control plane."
  command     = "`chmod +x /agent/scripts/restart_kubelet_service.sh && /agent/scripts/restart_kubelet_service.sh`"
  params      = ["NODE_NAME","USERNAME"]
  file_deps   = ["restart_kubelet_service"]
  enabled     = true
  depends_on  = [shoreline_file.restart_kubelet_service]
}


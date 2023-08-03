terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "node_not_ready_in_kubernetes_cluster" {
  source    = "./modules/node_not_ready_in_kubernetes_cluster"

  providers = {
    shoreline = shoreline
  }
}
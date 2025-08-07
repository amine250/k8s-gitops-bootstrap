terraform {
  required_version = ">= 1.12.2"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.17"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

# Configure Helm provider
provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "kind-admin-cluster"
  }
}
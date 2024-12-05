terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version =  "~> 5.40.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec { # workaround required because of aws-auth creation bug
    command     = "aws"
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
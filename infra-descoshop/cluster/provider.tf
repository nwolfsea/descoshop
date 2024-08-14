# provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-west-2"  # Altere para a região desejada
}

provider "kubernetes" {
  config_path = "~/.kube/config"  # Ajuste conforme necessário
}

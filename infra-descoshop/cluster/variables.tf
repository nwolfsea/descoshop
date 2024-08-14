# variables.tf
variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  default     = "my-cluster"
}

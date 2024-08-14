# main.tf
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-cluster"
  role_arn  = aws_iam_role.eks_cluster_role.arn
  version   = "1.24"  # Altere para a versão desejada

  vpc_config {
    subnet_ids = aws_subnet.my_subnet.*.id
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block  = "10.0.1.0/24"
}

resource "aws_security_group" "eks_sg" {
  vpc_id = aws_vpc.my_vpc.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.my_cluster.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.my_cluster.name
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.my_cluster.certificate_authority[0].data
}


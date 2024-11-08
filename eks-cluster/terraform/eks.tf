locals {
  subnet_a = "subnet-063d64332881c13ce"
  subnet_d = "subnet-00d61ee0ad1244ab6"
  subnet_b = "subnet-04da9d5f56b0891f6"
}

resource "aws_eks_cluster" "example" {
  name                      = "main-eks-demo"
  version                   = "1.29"
  enabled_cluster_log_types = ["api", "scheduler", "authenticator"]
  role_arn                  = aws_iam_role.example.arn

  vpc_config {
    subnet_ids              = [local.subnet_a, local.subnet_d, local.subnet_b]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.3-eksbuild.3"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "kube-proxy"
  addon_version = "v1.29.7-eksbuild.5"
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.2-eksbuild.2"
}

 resource "aws_eks_addon" "example" {
  cluster_name                = aws_eks_cluster.example.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.3-eksbuild.1"
  depends_on = [
    aws_eks_node_group.example
]
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

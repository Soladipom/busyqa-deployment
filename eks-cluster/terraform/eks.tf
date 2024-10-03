resource "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = concat(aws_subnet.public_subnet[*].id, aws_subnet.private_subnet[*].id)
    endpoint_public_access = true
    endpoint_private_access = false
  }

  depends_on = [aws_iam_role_policy_attachment.eks_policy]
}
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  # VPC config, etc.
}

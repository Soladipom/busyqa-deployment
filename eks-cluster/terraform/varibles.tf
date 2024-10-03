variable "region" {
  default = "ca-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  default = "main-eks-cluster"
}

variable "desired_capacity" {
  default = 3
}

variable "max_size" {
  default = 12
}

variable "min_size" {
  default = 3
}

variable "node_group_role" {
  description = "IAM role for the node group"
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role for the EKS cluster"
}

variable "eks_node_group_role_arn" {
  description = "ARN of the IAM role for the EKS worker nodes"
}

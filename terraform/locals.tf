locals {
    default_tags = {
        owner = "Joseph Gollner"
        environment = terraform.workspace
    }
    aws_managed_policies = {
        "AmazonEKSClusterPolicy"         = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
        "AmazonEKSServicePolicy"         = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
        "AmazonEKSVPCResourceController" = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
        "AmazonEKSWorkerNodePolicy"         = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        "AmazonEKS_CNI_Policy"         = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        "AmazonEC2ContainerRegistryReadOnly"         = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    }
}
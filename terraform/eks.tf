resource "aws_eks_cluster" "joseph_eks_cluster" {
    name        =   var.cluster_name
    role_arn    =   aws_iam_role.iam-role-for-eks-cluster.arn

    vpc_config {
        subnet_ids = tolist(aws_subnet.private_subnet.*.id)
    }
}

resource "aws_eks_node_group" "joseph_eks_cluster_node_group" {
  count           = var.node_count
  cluster_name    = aws_eks_cluster.joseph_eks_cluster.name
  node_group_name = "joseph_eks_cluster_node_group_${count.index}"
  node_role_arn   = aws_iam_role.iam-role-for-eks-node[count.index].arn
  subnet_ids      = tolist(aws_subnet.private_subnet.*.id)

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}
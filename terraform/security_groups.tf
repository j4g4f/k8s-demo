resource aws_security_group "node_group_access" {
    name        = "eks_cluster_nodes_network_access"
    vpc_id      = aws_vpc.joseph_eks_vpc.id
    tags = merge (
        local.default_tags,
        {
            Name = "EKS Cluster Nodes Network Access SG"
        }
    )
}

resource "aws_security_group_rule" "node_group_access" {
  for_each          = var.node_access_ingress
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = each.key
  cidr_blocks       = var.cluster_management_ingress_range
  security_group_id = aws_security_group.node_group_access.id
}

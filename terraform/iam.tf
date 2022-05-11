resource aws_iam_role "iam-role-for-eks-cluster" {
    name = "${var.cluster_name}-eks-role"
    assume_role_policy = file("policies/eks-assume-role-policy.json")
}

resource aws_iam_role_policy_attachment "cluster_access_1" {
    policy_arn      =   local.aws_managed_policies["AmazonEKSClusterPolicy"]
    role            =   aws_iam_role.iam-role-for-eks-cluster.name
}

resource aws_iam_role_policy_attachment "cluster_access_2" {
    policy_arn      =   local.aws_managed_policies["AmazonEKSServicePolicy"]
    role            =   aws_iam_role.iam-role-for-eks-cluster.name
}

resource aws_iam_role "iam-role-for-eks-node" {
    count = var.node_count
    name = "${var.cluster_name}-eks-node-${count.index}"
    assume_role_policy = file("policies/ec2-assume-role-policy.json")
}

resource aws_iam_role_policy_attachment "node_access_1" {
    count           =   var.node_count
    policy_arn      =   local.aws_managed_policies["AmazonEKSWorkerNodePolicy"]
    role            =   aws_iam_role.iam-role-for-eks-node[count.index].name
}

resource aws_iam_role_policy_attachment "node_access_2" {
    count           =   var.node_count
    policy_arn      =   local.aws_managed_policies["AmazonEKS_CNI_Policy"]
    role            =   aws_iam_role.iam-role-for-eks-node[count.index].name
}

resource aws_iam_role_policy_attachment "node_access_3" {
    count           =   var.node_count
    policy_arn      =   local.aws_managed_policies["AmazonEC2ContainerRegistryReadOnly"]
    role            =   aws_iam_role.iam-role-for-eks-node[count.index].name
}
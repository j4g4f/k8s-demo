resource aws_vpc "joseph_eks_vpc" {
    cidr_block  =   "10.0.0.0/16"
    tags = merge (
        local.default_tags,
        {
            Name = "Joseph EKS Learning VPC"
        }
    )
}

resource aws_subnet "private_subnet" {
    count       = length(var.private_subnets)
    vpc_id      = aws_vpc.joseph_eks_vpc.id
    cidr_block  = var.private_subnets[count.index]
    tags = merge (
        local.default_tags,
        {
            Name = join(" ", ["Private Subnet", count.index + 1])

        }
    )
}

resource aws_subnet "public_subnet" {
    count       = length(var.public_subnets)
    vpc_id      = aws_vpc.joseph_eks_vpc.id
    cidr_block  = var.public_subnets[count.index]
    tags = merge (
        local.default_tags,
        {
            Name = join(" ", ["Public Subnet", count.index + 1])

        }
    )
}
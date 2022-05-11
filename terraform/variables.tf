variable private_subnets {
    type    =   list
    description =   "A list of private subnets to create in the EKS VPC."
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable public_subnets {
    type    =   list
    description =   "A list of public subnets to create in the EKS VPC.  EKS worker nodes will not be provisioned here."
    default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable provider_env_profile {
    type    = map
    description =   "Maps the terraform workspace to the AWS profile to use to deploy.  This is usually a map for role ARNs, not profiles."
    default = {
        "development" = "joseph-uat-account"
        "production"  = "joseph-prod-account"
    }
}

variable aws_region {
    type    = string
    default = "us-east-2"
}

variable cluster_name {
    type = string
    description =   "The name of the EKS cluster to provision."
}

variable node_count {
    type = string
    description =   "How many Cluster nodes to create.  This will also create corresponding roles for the nodes."
}

variable node_access_ingress {
    type    =   map
    description =   "Ingress rules for the cluster nodes. Every key/value pair will create an ingress rule."
    default = {
        "tcp"    =   "22"
    }
}

variable cluster_management_ingress_range {
    type    =   list
    description =   "A CIDR range to allow for ingress traffic."
    default =   ["10.0.0.0/8"]
}
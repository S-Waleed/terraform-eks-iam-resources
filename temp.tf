
provider "kubernetes" {
  #   host                   = module.eks_blueprints.eks_cluster_endpoint
  #   cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", aws_eks_cluster.this.id]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_blueprints.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eks_blueprints.eks_cluster_id]
    }
  }
}

data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = join("-", [local.cluster_name, "vpc"])
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.vpc_name
  cidr = local.vpc_cidr
  azs  = local.azs

  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = true
  create_igw           = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  # IPV6
  enable_ipv6                     = true
  assign_ipv6_address_on_creation = true

  private_subnet_assign_ipv6_address_on_creation = false

  public_subnet_ipv6_prefixes   = [0, 1, 2]
  private_subnet_ipv6_prefixes  = [3, 3, 4]
  database_subnet_ipv6_prefixes = [5, 6, 7]
}

# resource "aws_vpc_ipam" "example" {
#   operating_regions {
#     region_name = data.aws_region.current.name
#   }
# }

# resource "aws_vpc_ipam_pool" "example" {
#   address_family = "ipv6"
#   ipam_scope_id  = aws_vpc_ipam.example.public_default_scope_id
#   locale         = data.aws_region.current.name
# }

# resource "aws_vpc_ipv6_cidr_block_association" "test" {
#   ipv6_ipam_pool_id = aws_vpc_ipam_pool.example.id
#   ipv6_cidr_block   = "2600:1f16:626:a500::/56"
#   vpc_id            = module.aws_vpc.vpc_id
# }

# module "eks_blueprints" {
#   source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.4"

#   # EKS CLUSTER
#   cluster_version    = "1.22"
#   vpc_id             = module.aws_vpc.vpc_id          # Enter VPC ID
#   private_subnet_ids = module.aws_vpc.private_subnets # Enter Private Subnet IDs
#   environment        = var.environment

#   # EKS MANAGED NODE GROUPS
#   # managed_node_groups = {
#   #   mg_t4 = {
#   #     node_group_name = "managed-SPOT"
#   #     capacity_type   = "SPOT" # ON_DEMAND or SPOT
#   #     instance_types  = ["t4.medium"]
#   #     subnet_ids      = module.aws_vpc.private_subnets
#   #     disk_size       = 5
#   #   }
#   # }

#   # tags = {
#   #   jobfunction = "DevOps"
#   # }

#   depends_on = [
#     module.aws_vpc
#   ]
# }


resource "aws_eks_cluster" "this" {
  name     = "role-tests"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.aws_vpc.private_subnets
  }

  depends_on = [
    aws_iam_role.eks_cluster_role,
    module.aws_vpc
  ]
}

# resource "aws_eks_node_group" "example" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = "example"
#   node_role_arn   = aws_iam_role.eks_node_role.arn
#   subnet_ids      = module.aws_vpc.private_subnets
#   capacity_type   = "SPOT"
#   instance_types  = ["t3.small"]
#   disk_size       = 4
#   ami_type        = "AL2_x86_64"

#   scaling_config {
#     desired_size = 1
#     max_size     = 1
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role.eks_node_role,
#     module.vpc_cni_irsa_role_ipv6
#   ]
# }

# todo: Verify aws-node irsa


# provider "kubernetes" {
#   #   host                   = module.eks_blueprints.eks_cluster_endpoint
#   #   cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1alpha1"
#     command     = "aws"
#     # This requires the awscli to be installed locally where Terraform is executed
#     args = ["eks", "get-token", "--cluster-name", module.eks_blueprints.eks_cluster_id]
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.eks_blueprints.eks_cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

#     exec {
#       api_version = "client.authentication.k8s.io/v1alpha1"
#       command     = "aws"
#       # This requires the awscli to be installed locally where Terraform is executed
#       args = ["eks", "get-token", "--cluster-name", module.eks_blueprints.eks_cluster_id]
#     }
#   }
# }

# data "aws_availability_zones" "available" {}

# locals {
#   region = "us-east-1"

#   vpc_cidr = "10.0.0.0/16"
#   vpc_name = join("-", [local.cluster_name, "vpc"])
#   azs      = slice(data.aws_availability_zones.available.names, 0, 3)
# }

# module "aws_vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 3.0"

#   name = local.vpc_name
#   cidr = local.vpc_cidr
#   azs  = local.azs

#   public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
#   private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 10)]

#   enable_nat_gateway   = true
#   create_igw           = true
#   enable_dns_hostnames = true
#   single_nat_gateway   = true

#   public_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/elb"                      = "1"
#   }

#   private_subnet_tags = {
#     "kubernetes.io/cluster/${local.cluster_name}" = "shared"
#     "kubernetes.io/role/internal-elb"             = "1"
#   }
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

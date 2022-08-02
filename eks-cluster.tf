# FOR DEV ONLY

locals {
  vpc_cidr = "10.0.0.0/16"
  vpc_name = join("-", [local.cluster_name, "vpc"])
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "aws_vpc_example" {
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
}


resource "aws_eks_cluster" "simple_example" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.aws_vpc_example.private_subnets
  }

  depends_on = [
    aws_iam_role.eks_cluster_role,
    module.aws_vpc_example
  ]
}

resource "aws_eks_node_group" "simple_example" {
  cluster_name    = aws_eks_cluster.simple_example.name
  node_group_name = "simple-example"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = module.aws_vpc_example.private_subnets
  capacity_type   = "SPOT"
  instance_types  = ["t3.small"]
  disk_size       = 4
  ami_type        = "AL2_x86_64"

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role.eks_node_role,
  ]
}

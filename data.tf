data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.simple_example.id
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.this.id
}
# #######################
# Read all EKS clusters
# #######################

data "aws_iam_policy_document" "read_all_eks_clusters" {
  statement {
    sid = "ReadAllEKSclusters"

    actions = [
      "eks:AccessKubernetesApi",
      "eks:DescribeCluster",
      "eks:ListAddons",
      "eks:ListFargateProfiles",
      "eks:ListIdentityProviderConfigs",
      "eks:ListNodegroups",
      "eks:ListTagsForResource",
      "eks:ListUpdates"
    ]

    resources = [
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*",
    ]
  }

  statement {
    sid = "ListAllEKSclusters"

    actions = [
      "eks:ListClusters"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "read_all_eks_clusters" {
  name   = "read-all-eks-clusters"
  path   = "/"
  policy = data.aws_iam_policy_document.read_all_eks_clusters.json

  tags = {
    "Name" = "read-all-eks-clusters"
  }
}

# #############################
# Read a specific EKS cluster
# #############################

data "aws_iam_policy_document" "read_a_eks_cluster" {
  statement {
    sid = "ReadAEKScluster"

    actions = [
      "eks:AccessKubernetesApi",
      "eks:DescribeCluster",
      "eks:ListAddons",
      "eks:ListFargateProfiles",
      "eks:ListIdentityProviderConfigs",
      "eks:ListNodegroups",
      "eks:ListTagsForResource",
      "eks:ListUpdates"
    ]

    resources = [
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${local.cluster_name}",
    ]
  }
}

resource "aws_iam_policy" "read_a_eks_cluster" {
  name   = "read-a-eks-cluster"
  path   = "/"
  policy = data.aws_iam_policy_document.read_a_eks_cluster.json

  tags = {
    "Name" = "read-a-eks-cluster"
  }
}

# ########################
# Modify all EKS clusters
# ########################

data "aws_iam_policy_document" "modify_all_eks_clusters" {

  statement {
    sid = "ModifyAllEKSclusters"

    actions = [
      "eks:AccessKubernetesApi",
      "eks:Associate*",
      "eks:Create*",
      "eks:Delete*",
      "eks:DeregisterCluster",
      "eks:DisassociateIdentityProviderConfig",
      "eks:Describe*",
      "eks:List*",
      "eks:RegisterCluster",
      "eks:TagResource",
      "eks:UntagResource",
      "eks:Update*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "Deny"

    # No major updates allowed in this example
    actions = [
      "eks:CreateCluster",
      "eks:DeleteCluster"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "modify_all_eks_clusters" {
  name   = "modify-all-eks-clusters"
  path   = "/"
  policy = data.aws_iam_policy_document.modify_all_eks_clusters.json

  tags = {
    "Name" = "modify-all-eks-clusters"
  }
}

# ##############################
# Modify a specific EKS cluster
# ##############################

data "aws_iam_policy_document" "modify_a_eks_cluster" {

  statement {
    sid = "ModifyaEKScluster"

    actions = [
      "eks:AccessKubernetesApi",
      "eks:Associate*",
      "eks:Create*",
      "eks:Delete*",
      "eks:DeregisterCluster",
      "eks:DescribeCluster",
      "eks:DescribeUpdate",
      "eks:List*",
      "eks:TagResource",
      "eks:UntagResource",
      "eks:Update*"
    ]

    resources = [
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${local.cluster_name}",
    ]
  }

  statement {
    sid = "ModifyaEKSclusterResource"

    actions = [
      "eks:DescribeNodegroup",
      "eks:DescribeFargateProfile",
      "eks:DescribeIdentityProviderConfig",
      "eks:DescribeAddon"
    ]

    resources = [
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/${local.cluster_name}",
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:nodegroup/${local.cluster_name}/*/*",
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:addon/${local.cluster_name}/*/*",
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:identityproviderconfig/${local.cluster_name}/*/*/*",
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:fargateprofile/${local.cluster_name}/*/*"
    ]
  }

  # These actions don't use the 'cluster' resource type
  statement {
    sid = "Modify"

    actions = [
      "eks:RegisterCluster",
      "eks:DisassociateIdentityProviderConfig"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = "Deny"

    # No major updates allowed in this example
    effect = "Deny"
    actions = [
      "eks:CreateCluster",
      "eks:DeleteCluster"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "modify_a_eks_cluster" {
  name   = "modify-a-eks-cluster"
  path   = "/"
  policy = data.aws_iam_policy_document.modify_a_eks_cluster.json

  tags = {
    "Name" = "modify-a-eks-cluster"
  }
}

# #########################################
# Permissions by EKS cluster resource name
# #########################################

data "aws_iam_policy_document" "eks_cluster" {

  statement {
    sid = "ModifyAllEKSclusters"

    actions = [
      "eks:AccessKubernetesApi",
      "eks:Associate*",
      "eks:Create*",
      "eks:Delete*",
      "eks:DeregisterCluster",
      "eks:Describe*",
      "eks:List*",
      "eks:RegisterCluster",
      "eks:TagResource",
      "eks:UntagResource",
      "eks:Update*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "Deny"

    # No major updates allowed in this example
    effect = "Deny"
    actions = [
      "eks:CreateCluster",
      "eks:DeleteCluster"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "eks_cluster" {
  name   = "modify-all-eks-clusters-resource"
  path   = "/"
  policy = data.aws_iam_policy_document.modify_all_eks_clusters.json

  tags = {
    "Name" = "modify-all-eks-clusters-resource"
  }
}

# #########################################
# EKS Console Admin
# #########################################

data "aws_iam_policy_document" "console_admin" {

  statement {
    sid = "admin"

    actions = [
      "eks:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "console"

    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values   = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "console_admin" {
  name   = "eks-console-admin"
  path   = "/"
  policy = data.aws_iam_policy_document.console_admin.json

  tags = {
    "Name" = "eks-console-admin"
  }
}

# #########################################
# EKS Cluster Version update
# #########################################

data "aws_iam_policy_document" "cluster_version" {

  statement {
    sid = "admin"

    actions = [
      "eks:UpdateClusterVersion"
    ]

    resources = [
      "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/environment"
      values   = ["sandbox"]
    }
  }
}

resource "aws_iam_policy" "cluster_version" {
  name   = "eks-cluster-version"
  path   = "/"
  policy = data.aws_iam_policy_document.cluster_version.json

  tags = {
    "Name" = "eks-cluster-version"
  }
}

# #########################################
# Amazon VPC CNI IPV6
# #########################################

data "aws_iam_policy_document" "vpc_cni_ipv6" {

  statement {
    actions = [
      "ec2:AssignIpv6Addresses",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeInstanceTypes"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "tag"

    actions = [
      "ec2:CreateTags"
    ]

    resources = [
      "arn:aws:ec2:*:*:network-interface/*"
    ]
  }
}

resource "aws_iam_policy" "vpc_cni_ipv6" {
  name   = "eks-vpc-cni-ipv6"
  path   = "/"
  policy = data.aws_iam_policy_document.vpc_cni_ipv6.json

  tags = {
    "Name" = "eks-vpc-cni-ipv6"
  }
}

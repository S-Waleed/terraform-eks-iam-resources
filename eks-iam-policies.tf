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

# todo: Customize arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
# with conditions to restrict calls from network

data "aws_iam_policy_document" "cluster_role" {

  statement {
    sid    = "write"
    effect = "Allow"
    actions = [
      "autoscaling:UpdateAutoScalingGroup",
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateRoute",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteRoute",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteVolume",
      "ec2:DetachVolume",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifyVolume",
      "ec2:RevokeSecurityGroupIngress",
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:CreateTargetGroup",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:DeleteLoadBalancerListeners",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:DetachLoadBalancerFromSubnets",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "elasticloadbalancing:SetLoadBalancerPoliciesOfListener"
    ]

    resources = [
      "*"
    ]

    # Only allow if it's another AWS service
    condition {
      test     = "Bool"
      variable = "aws:ViaAWSService"
      values   = ["true"]
    }

    # Only allow if the call is from this same account
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    # condition {
    #   test     = "IpAddress"
    #   variable = "aws:SourceIp"
    #   values   = [local.current_ip_address]
    # }
  }

  statement {
    sid    = "read"
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "kms:DescribeKey",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeLoadBalancerPolicies",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetHealth",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeInstances",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeVpcs",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces"
    ]

    resources = ["*"]

  }

  statement {
    effect    = "Allow"
    actions   = ["iam:CreateServiceLinkedRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values   = ["elasticloadbalancing.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "cluster_role" {
  name   = "eks-cluster-role"
  path   = "/"
  policy = data.aws_iam_policy_document.cluster_role.json

  tags = {
    "Name" = "eks-cluster-role"
  }
}

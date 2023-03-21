# Amazon EKS cluster IAM role

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  tags = local.required_tags

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Amazon EKS node IAM role

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"
  tags = local.required_tags

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_node_role" {
  for_each = toset(local.eks_node_policies)

  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
  role       = aws_iam_role.eks_node_role.name
}

# Amazon EKS VPC CNI IRSA | IPV4
module "vpc_cni_irsa" {
  source = "git@github.com:aws-ia/terraform-aws-eks-blueprints.git//modules/irsa?ref=v4.2.1"

  kubernetes_namespace              = "kube-system"
  kubernetes_service_account        = "aws-node"
  create_kubernetes_namespace       = false
  create_kubernetes_service_account = false
  irsa_iam_policies                 = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
  addon_context                     = local.addon_context
}

# Amazon EKS pod execution IAM role

resource "aws_iam_role" "eks_pod_exe_role" {
  name = "eks-fargate-pod-execution-role"
  tags = local.required_tags

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks-fargate-pods.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
         "ArnLike": {
            "aws:SourceArn": "arn:aws:eks:${var.region}:${data.aws_caller_identity.current.account_id}:fargateprofile/${local.cluster_name}/*"
         }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_pod_exe_role" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks_pod_exe_role.name
}

# Amazon EKS Connector IAM role

resource "aws_iam_role" "eks_connector_role" {
  name = "eks-connector-role"
  tags = local.required_tags

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_connector_role" {
  policy_arn = aws_iam_policy.connector.arn
  role       = aws_iam_role.eks_connector_role.name
}

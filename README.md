# Amazon EKS IAM resources

Various Amazon EKS IAM policies and AWS IAM roles in Terraform. See [blog](https://cloudly.engineer/?p=1600) for details.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_vpc"></a> [aws\_vpc](#module\_aws\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
| <a name="module_vpc_cni_irsa"></a> [vpc\_cni\_irsa](#module\_vpc\_cni\_irsa) | git@github.com:aws-ia/terraform-aws-eks-blueprints.git//modules/irsa | v4.2.1 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/eks_cluster) | resource |
| [aws_iam_policy.cluster_version](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.connector](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.console_admin](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.modify_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.modify_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_connector_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_pod_exe_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_connector_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_node_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_pod_exe_role](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.cluster_version](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.connector](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.console_admin](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.modify_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.modify_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/region) | data source |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS Account ID number of the account. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Author

Waleed from <https://cloudly.engineer>

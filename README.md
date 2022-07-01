# Amazon EKS IAM Policies

Various EKS IAM policies and AWS IAM roles in Terraform.

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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cluster_version](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.console_admin](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.modify_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.modify_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.read_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cluster_version](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.console_admin](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.modify_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.modify_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_a_eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.read_all_eks_clusters](https://registry.terraform.io/providers/hashicorp/aws/4.2.0/docs/data-sources/iam_policy_document) | data source |

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

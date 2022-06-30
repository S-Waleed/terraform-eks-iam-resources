variable "region" {
  type        = string
  description = "The AWS region."
}

variable "environment" {
  type        = string
  description = "Environment name."
}

variable "account_id" {
  type        = string
  description = "AWS Account ID number of the account."
}

variable "eks_cluster_id" {
  description = "EKS Cluster Id"
  type        = string
}
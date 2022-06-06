terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }
  }

  backend "s3" {
    key      = "tf-aws-iam-resources/terraform-main.tfstate"
    bucket   = "cloudly-engineer-sandbox-tf-state"
    region   = "us-east-2"
    role_arn = "arn:aws:iam::583202145612:role/svc-terraform-role"
  }
}

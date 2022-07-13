provider "aws" {
  region = var.region

  # Common tags for all resources that accept tags
  default_tags {
    tags = {
      ManagedBy   = "Terraform"
      environment = var.environment
      Owner       = "Waleed"
      project-id  = "sales-123"
    }
  }
}

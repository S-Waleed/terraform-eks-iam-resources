SHELL := /usr/bin/env bash

# HOW TO EXECUTE

# Executing Terraform PLAN
#	$ make tf-plan-iam-policies env=<env>
#    e.g.,
#       make tf-plan-iam-policies env=dev

# Executing Terraform APPLY
#   $ make tf-apply-iam-policies env=<env>

# Executing Terraform DESTROY
#	$ make tf-destroy-iam-policies env=<env>

all-test: clean tf-plan-iam-policies

.PHONY: clean
clean:
	rm -rf .terraform

.PHONY: tf-plan-iam-policies
tf-plan-iam-policies:
	terraform fmt && terraform init -backend-config accounts/${env}/backend.conf -reconfigure && terraform validate && terraform plan -var-file accounts/${env}/terraform.tfvars

.PHONY: tf-apply-iam-policies
tf-apply-iam-policies:
	terraform fmt && terraform init -backend-config accounts/${env}/backend.conf -reconfigure && terraform validate && terraform apply -var-file accounts/${env}/terraform.tfvars -auto-approve

.PHONY: tf-destroy-iam-policies
tf-destroy-iam-policies:
	terraform init -backend-config accounts/${env}/backend.conf -reconfigure && terraform destroy -var-file accounts/${env}/terraform.tfvars

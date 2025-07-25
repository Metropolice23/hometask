# This file contains the Terraform provider configuration for AWS.

# Specify the AWS provider and its region.
provider "aws" {
  region = local.aws_region
}

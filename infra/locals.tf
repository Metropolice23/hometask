locals {
  # Specify the AWS region for the resources
  aws_region = coalesce(var.aws_region, "us-east-1")
  # Specify the instance type
  instance_type = coalesce(var.instance_type, "t2.micro")
  # Specify the AMI ID for the instance
  ami_id = coalesce(var.ami_id, "ami-0c55b159cbfafe1f0")
  # Specify the SSH key name for remote execution

  # Define the SSH key name
  ssh_key_name    = coalesce(var.ssh_key_name, "my-ec2-key")

  # Define the full paths for the SSH keys
  private_ssh_key = "~/.ssh/${ssh_key_name}.pem"
  public_ssh_key  = "~/.ssh/${ssh_key_name}.pub"

  # Define the default tags for the resources
  tags = {
    Name      = "simple-web"
    Terraform = "true"
  }
}

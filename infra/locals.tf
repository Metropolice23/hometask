locals {
  # Specify the AWS region for the resources
  aws_region = "us-east-1"
  # Specify the instance type
  instance_type = "t2.micro"
  # Specify the AMI ID for the instance
  ami_id = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS in us-east-1
  # Specify the SSH private key path for remote execution
  ssh_private_key_path = "~/.ssh/my-ec2-key.pem"
}

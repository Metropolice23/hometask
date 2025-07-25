# This file contains Terraform output definitions for the EC2 instance.

# output for the public IP of the EC2 instance
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

# output for the instance ID of the EC2 instance
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

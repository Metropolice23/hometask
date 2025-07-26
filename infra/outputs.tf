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

# output for the public DNS of the EC2 instance
output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.web.public_dns
}

# output for the security group ID
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

# output for the SSH key pair name
output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.uploaded_key.key_name
}

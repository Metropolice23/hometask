
# This file contains the Terraform configuration for an AWS EC2 instance.

# Passing public key to AWS account
resource "aws_key_pair" "uploaded_key" {
  key_name   = local.ssh_key_name
  public_key = file(local.public_ssh_key)
}

# EC2 instance resource definition
resource "aws_instance" "web" {
  ami           = local.ami_id
  instance_type = local.instance_type
  key_name      = aws_key_pair.uploaded_key.key_name
  security_groups = [aws_security_group.web_sg.name]

  # filepath: /Users/omrishur/hometask/infra/ec2.tf
  provisioner "env_file" {
    source      = "${path.module}/flask-app.env"
    destination = "/tmp/flask-app.env"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local.private_ssh_key)
      host        = self.public_ip
    }
  }

  # provisioning block to install Docker and run the app-image
  provisioner "remote-exec" {
    inline = [
      # Docker installation commands
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker-ce",
      # set the environment variables file for the app-image
      "sudo mv /tmp/flask-app.env ${var.app_env_file_path}",
      "sudo chmod 644 ${var.app_env_file_path}",
      # run the Docker container with the app-image
      "sudo docker run --env-file ${var.app_env_file_path} -d -p 80:${var.app_port}  -v ${var.ec2_logs_path}:/${var.app_logs_path}  ${var.docker_image}:${var.docker_tag}"
    ]

    # Connection details for the remote execution
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local.private_ssh_key)
      host        = self.public_ip
    }
  }

  tags = local.tags
}


# This file contains the Terraform configuration for an AWS EC2 instance.

# EC2 instance resource definition
resource "aws_instance" "web" {
  ami           = local.ami_id
  instance_type = local.instance_type
  security_groups = [aws_security_group.web_sg.name]

  # filepath: /Users/omrishur/hometask/infra/ec2.tf
  provisioner "env_file" {
    source      = "${path.module}/flask-app.env"
    destination = "/tmp/flask-app.env"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local.ssh_private_key_path)
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
      "sudo mv /tmp/flask-app.env /opt/flask-app.env",
      "sudo chmod 644 /opt/flask-app.env",
      # run the Docker container with the app-image
      "sudo docker run --env-file /opt/flask-app.env -d -p 80:${var.app_port} ${var.docker_image}:${var.docker_tag}"
    ]

    # Connection details for the remote execution
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(local.ssh_private_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = "simple-web"
  }
}

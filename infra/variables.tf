variable "aws_region" {
  description = "AWS region, if not specified, defaults to us-east-1"
  type        = string
  default     = null
  validation {
    condition     = can(regex("^([a-z]{2}-[a-z]+-\\d)$", var.aws_region)) || var.aws_region == null
    error_message = "aws_region must be a valid AWS region (e.g., us-east-1)."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the EC2 instance if not specified, defaults to t2.micro"
  type        = string
  default     = null
  validation {
    condition     = contains(["t2.micro", "t3.micro", "t2.small", "t3.small"], var.instance_type) || var.instance_type == null
    error_message = "instance_type must be one of: t2.micro, t3.micro, t2.small, t3.small."
  }
}

variable "ami_id" {
  description = "AMI id for the EC2 instance if not specified, defaults to ami-0c55b159cbfafe1f0 (Ubuntu 22.04 LTS in us-east-1)"
  type        = string
  default     = null

  validation {
    condition     = var.ami_id == null || can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))
    error_message = "ami_id must start with 'ami-' and contain only letters and numbers (e.g., ami-0c55b159cbfafe1f0)."
  }
}

variable "ssh_key_name" {
  description = "SSH private key path for remote execution"
  type        = string
  default     = null
}

variable "my_ip" {
  description = "Your public IP address for SSH access (without /32)"
  type        = string
  sensitive   = true
}

variable "app_port" {
  description = "The port on which the Flask app will run"
  type        = number
  default     = 8080
}

variable "docker_image" {
  description = "The Docker image to use for the Flask app"
  type        = string
  default     = "metropolice/simple-app"
}

variable "docker_tag" {
  description = "The Docker image tag to use for the Flask app"
  type        = string
  default     = "latest"
}

variable "app_logs_path" {
  description = "The path to the application logs directory"
  type        = string
  default     = "app/logs"
}

variable "ec2_logs_path" {
  description = "The path to the EC2 instance logs directory"
  type        = string
  default     = "/var/log/flask-app"
}

variable "app_env_file_path" {
  description = "The path to the environment variables file for the Flask app"
  type        = string
  default     = "/opt/flask-app.env"
}

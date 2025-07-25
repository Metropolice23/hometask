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

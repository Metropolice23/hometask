# Terraform AWS EC2 Flask App Deployment

This directory contains the Terraform code for provisioning and deploying the Flask web application on AWS EC2, including Docker installation, environment variable management, and log mapping.

---

## What This Terraform Script Does

- Provisions an EC2 instance (Ubuntu 22.04 LTS by default).
- Uploads your SSH public key for secure access.
- Configures a security group for SSH (from your IP) and HTTP (from anywhere).
- Installs Docker and runs the Flask app container with environment variables and log mapping.
- Outputs the instance’s public IP and instance ID.

---

## Usage Instructions

1. **Clone the repository.**
2. **Authenticate to your AWS account** (see main project README).
3. **Generate an SSH key pair** (if you don’t have one):
   ```sh
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/my-ec2-key
   ```
4. **Set your variables** (either in `terraform.tfvars` or via CLI/environment):
   - `my_ip` (your public IP, without `/32`)
   - Any overrides for region, instance type, AMI, etc.
5. **Run Terraform:**
   ```sh
   cd infra
   terraform init
   terraform apply
   ```
6. **After deployment:**
   - Access your app via the output public IP.
   - SSH into your instance using your private key.
   - View logs at `/var/log/flask-app/app.log`.

---

## Terraform Variable Reference

Below are the main variables you can configure for this deployment:

| Variable Name         | Type     | Default                        | Description                                      |
|-----------------------|----------|--------------------------------|--------------------------------------------------|
| `aws_region`          | string   | `"us-east-1"`                  | AWS region for resources                         |
| `instance_type`       | string   | `"t2.micro"`                   | EC2 instance type                                |
| `ami_id`              | string   | `"ami-0c55b159cbfafe1f0"`      | AMI ID for the EC2 instance (Ubuntu 22.04 LTS)   |
| `ssh_key_name`        | string   | `"my-ec2-key"`                 | Name for the EC2 key pair                        |
| `my_ip`               | string   | _no default (required)_        | Your public IP for SSH access (without `/32`)    |
| `app_port`            | string   | `"8080"`                       | Port the Flask app listens on inside the container|
| `docker_image`        | string   | `"yourdockerhub/simple-app"`   | Docker image to run                              |
| `docker_tag`          | string   | `"latest"`                     | Docker image tag                                 |

**Note:**
- All variables can be overridden in `terraform.tfvars` or via CLI.
- Some variables (like `my_ip`) are required for security.

---

## Security Considerations

- SSH access is restricted to your IP.
- Private keys are never committed to version control.
- Sensitive variables should be provided securely (e.g., via `terraform.tfvars` or environment variables).

---

## Outputs

- `public_ip`: The public IP address of the EC2 instance.
- `instance_id`: The AWS EC2 instance ID.

---

**For more details on the application, CI/CD, and observability, see the main project README.**

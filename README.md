# Minimal Python Web Application Deployment

## What I Built

This project demonstrates a fully automated deployment of a minimal Python (Flask) web application using Docker, Terraform, and GitHub Actions. The solution provisions AWS infrastructure, builds and pushes a Docker image, and runs the application on an EC2 instance with environment-specific configuration and basic observability.

---

## End-to-End Automation Overview

1. **Application**
   - A simple Flask API with endpoints for main info, health check, and a static message.
   - Logging is configured to write both to the console and to a file.

2. **Containerization**
   - The app is containerized using a Dockerfile.
   - The image is built and pushed to Docker Hub via a GitHub Actions workflow.

3. **CI/CD**
   - GitHub Actions workflow (`.github/workflows/ci.yaml`) builds and pushes the Docker image on every push to `main`.
   - secrets `DOCKERHUB_TOKEN` & `DOCKERHUB_USERNAME` are configured inside the Github repository's secrets.

4. **Infrastructure Provisioning**
   - Terraform scripts in the `infra/` directory provision:
     - An EC2 instance (Ubuntu 22.04).
     - A security group allowing SSH (from your IP) and HTTP (from anywhere).
     - `my_ip` variable can be configured thru `terraform.tfvars` file
     - An EC2 key pair for SSH access.
   - Terraform provisioners install Docker, upload environment variables, and run the container.

5. **Configuration Management**
   - Application environment variables are managed via a `flask-app.env` file, uploaded to the EC2 instance by Terraform.
   - The Docker container is started with these environment variables.

6. **Observability**
   - Application logs are written to `/app/logs/app.log` inside the container.
   - Docker mounts this directory to `/var/log/flask-app` on the EC2 host, making logs accessible from the host.

---

## Application Configuration

- All configuration (such as port, environment, secrets) is managed via environment variables.
- These variables are defined in a local `flask-app.env` file and uploaded to the EC2 instance by Terraform.
- The Docker container uses the `--env-file` flag to load these variables at runtime.
- Terraform variables and locals allow easy overrides for AWS region, instance type, AMI, and SSH key.

---

## Observability Integration

- The Flask app uses Python’s `logging` module to log to both the console and a file.
- Docker mounts the app’s log directory to the EC2 host, so logs are available at `/var/log/flask-app/app.log`.
- 404 errors and endpoint accesses are logged for basic monitoring.

---

## Key Security Considerations

- SSH access is restricted to your IP via the security group.
- SSH key pairs are managed securely; private keys are never committed to version control.
- Sensitive configuration (such as secrets) is passed via environment variables and not hard-coded.
- Docker and system packages are installed with the least privilege necessary.
- The `build.env` file and any sensitive files should be excluded from version control.

---

## Assumptions & Decisions

- The deployment targets Ubuntu 22.04 LTS on AWS EC2.
- Docker Hub is used as the container registry.
- The solution uses Terraform provisioners for simplicity; for production, a dedicated configuration management tool is recommended.
- The user is responsible for managing their own SSH keys and secrets.
- The default security group allows HTTP from anywhere and SSH only from a specified IP.

---

## How to Use

1. **Clone the repository.**
2. **Authenticate to your AWS account**
   - Make sure your AWS credentials are configured locally (e.g., using `aws configure` or by setting `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as environment variables).
3. **Set up your SSH key pair**
   - Run this command to create the key:
     `ssh-keygen -t rsa -b 4096 -f ~/.ssh/my-ec2-key`
4. **Configure your variables** in `flask-app.env`.
5. **Configure your IP** in `terraform.tfvars` or via CLI.
6. **Push to GitHub** to trigger the CI/CD pipeline.
7. **Run `terraform apply`** in the `infra/` directory to provision infrastructure and deploy the app.
8. **Access logs** on the EC2 instance at `/var/log/flask-app/app.log`.

---

Feel free to adapt this project for your own use cases!

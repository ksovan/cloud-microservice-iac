terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS deployment region"
}

variable "docker_image" {
  type        = string
  default     = "ksovan/cloud-microservice:v1"
  description = "Docker image to run on the server"
}

# 1. Firewall Rules (Security Group)
resource "aws_security_group" "api_sg" {
  name        = "microservice-sg"
  description = "Allow inbound HTTP (80) and SSH (22)"

  ingress {
    description = "HTTP Inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. AWS EC2 Server Instance
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (us-east-1)
  instance_type = "t3.micro"              # AWS Free Tier eligible
  
  security_groups = [aws_security_group.api_sg.name]

  # Startup script: Runs automatically when the cloud server boots up
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              docker run -d -p 80:8000 --name microservice ${var.docker_image}
              EOF

  tags = {
    Name        = "CloudMicroserviceHost"
    Environment = "Dev"
  }
}

# 3. Output the public IP address after creation
output "public_ip" {
  value       = aws_instance.app_server.public_ip
  description = "Public IP address of the EC2 instance"
}
# Cloud Microservice IaC Pipeline

A containerized Python FastAPI health check microservice automatically provisioned on AWS EC2 using Docker and Terraform Infrastructure as Code (IaC).

## Architecture & Workflow

[FastAPI Code] ──> [Docker Build] ──> [Docker Hub] ──> [Terraform main.tf] ──> [AWS EC2 (t3.micro)]
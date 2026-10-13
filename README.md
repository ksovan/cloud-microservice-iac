# Cloud Microservice IaC Pipeline

A containerized Python FastAPI health check microservice automatically provisioned on AWS EC2 using Docker and Terraform Infrastructure as Code (IaC).

##  Architecture & Workflow

[FastAPI Code] ──> [Docker Build] ──> [Docker Hub] ──> [Terraform main.tf] ──> [AWS EC2 (t3.micro)]


## Prerequisites
  - Docker Desktop installed and running
  - Terraform installed
  - AWS CLI configured with valid credentials


1. Build and Push Container Image
  - docker build -t cloud-microservice:v1 .
  - docker tag cloud-microservice:v1 ksovan/cloud-microservice:v1
  - docker push ksovan/cloud-microservice:v1

2. Deploy AWS Infrastructure via Terraform
  - cd terraform
  - terraform init
  - terraform apply

3. Verify Live Service
Once Terraform finishes, copy the public IP from the terminal output and test the microservice:
  - http://<AWS_EC2_PUBLIC_IP>/docs

4. Cleanup Infrastructure
To tear down all provisioned cloud resources and prevent unexpected AWS charges:
  - terraform destroy. it doesnt miss anything 


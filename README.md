# Docker-ECS-Terraform

This project demonstrates the deployment of NGINX on AWS ECS with Fargate Launch Type using Terraform.

## Tasks

### 1. Deploy NGINX on AWS ECS

#### 1.1 Fargate Deployment

Pull NGINX image from Docker Hub Registry and create a container using AWS ECS with Fargate Launch Type. Choose between deployment on Private or Public Subnets.

**Note:** Ensure that the NGINX image is read from the Docker Hub Registry.

### 2. GitHub Workflow for Terraform

A GitHub workflow has been set up to run Terraform code, automating the infrastructure deployment process.

## List of Created Resources

- **VPC:**
  - Public Subnets
  - Private Subnets
  - Internet Gateway
  - NAT Gateway
  - Route Tables
  - Security Groups
    - ECS Security Groups: Ingress and Egress rules configured for ECS requirements.
    - ALB Security Group: Ingress rules for ALB communication.

- **IAM Role:**
  - IAM Role with actions = ["sts:AssumeRole"]
  - Attached service-role/AmazonECSTaskExecutionRolePolicy for ECS execution.

- **Application Load Balancer (ALB):**
  - ALB with Listeners and Target Groups configured.
  - ALB Security Group: Ingress rules for ALB communication.

- **ECS Cluster:**
  - ECS Service
  - ECS Tasks

- **Terraform State Storage:**
  - Utilized an S3 bucket for storing the Terraform state file.

## Terraform State Management

The Terraform state file is stored remotely in an S3 bucket. This ensures centralized state management and collaboration among team members.

## Getting Started

To deploy NGINX on AWS ECS and set up the infrastructure, follow the steps below:

1. Clone this repository:
   ```bash
   git clone https://github.com/DaniyaDi/project-2.git

2. 

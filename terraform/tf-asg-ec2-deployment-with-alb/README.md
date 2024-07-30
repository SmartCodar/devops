
# 🚀 Deploying an Auto Scaling Group with Nginx and Application Load Balancer using Terraform 🚀

## Introduction

In this guide, we'll walk through the **exciting** steps to deploy an Auto Scaling Group (ASG) with an Nginx installation, a health endpoint, an Application Load Balancer (ALB), and a target group using **Terraform**. This structured approach helps in managing and deploying the infrastructure **efficiently and effectively**. 

### User-Configured Values

Throughout this guide, you will need to replace placeholders with your specific values:
- `REGION`: Your AWS region, e.g., `us-west-2`
- `VPC_ID`: Your VPC ID
- `SUBNET_ID`: Your Subnet ID
- `AMI_ID`: Your Amazon Machine Image ID
- `INSTANCE_TYPE`: Your desired EC2 instance type, e.g., `t2.micro`

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
- [Terraform](https://www.terraform.io/downloads.html)
- AWS CLI configured with appropriate permissions

## Terraform Files and Descriptions

### `provider.tf`

The `provider.tf` file configures the AWS provider.

```hcl
# provider.tf

provider "aws" {
  region = "REGION"  # Replace with your AWS region
}
```

### `variables.tf`

The `variables.tf` file defines the variables used throughout the Terraform configuration.

```hcl
# variables.tf

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "REGION"  # Replace with your AWS region
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID where resources will be deployed"
  type        = string
}

variable "ami_id" {
  description = "The Amazon Machine Image ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "INSTANCE_TYPE"  # Replace with your desired EC2 instance type
}
```

### `terraform.tfvars`

The `terraform.tfvars` file specifies the values for the variables defined in `variables.tf`.

```hcl
# terraform.tfvars

region        = "REGION"         # Replace with your AWS region
vpc_id        = "VPC_ID"         # Replace with your VPC ID
subnet_id     = "SUBNET_ID"      # Replace with your Subnet ID
ami_id        = "AMI_ID"         # Replace with your AMI ID
instance_type = "INSTANCE_TYPE"  # Replace with your desired EC2 instance type
```

### `main.tf`

The `main.tf` file includes the main configuration for deploying the ASG and ALB.

```hcl
# main.tf

module "autoscaling" {
  source = "./autoscaling"
}

module "load_balancer" {
  source = "./load_balancer"
}
```

### `autoscaling.tf`

The `autoscaling.tf` file defines the resources for the Auto Scaling Group and the Nginx installation.

```hcl
# autoscaling.tf

resource "aws_launch_configuration" "nginx" {
  name          = "nginx-launch-configuration"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y nginx
                systemctl start nginx
                systemctl enable nginx
                EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "nginx_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  launch_configuration = aws_launch_configuration.nginx.id
  vpc_zone_identifier  = [var.subnet_id]

  tag {
    key                 = "Name"
    value               = "nginx-asg-instance"
    propagate_at_launch = true
  }
}
```

### `load_balancer.tf`

The `load_balancer.tf` file defines the resources for the Application Load Balancer and the target group.

```hcl
# load_balancer.tf

resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.subnet_id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
```

### `outputs.tf`

The `outputs.tf` file defines the output values for the Terraform configuration.

```hcl
# outputs.tf

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.nginx_asg.name
}
```

## Deploying the Infrastructure

With all the Terraform configurations in place, you can deploy the infrastructure by running the following commands:

1. **Initialize Terraform:**

    ```sh
    terraform init
    ```

2. **Apply the Configuration Automatically:**

    ```sh
    terraform apply -auto-approve
    ```

### What to Look for in the Output

After running `terraform apply`, look for the following outputs to verify your deployment:

- **alb_dns_name**: The DNS name of the Application Load Balancer. You can access your Nginx server using this DNS name.
- **asg_name**: The name of the Auto Scaling Group. This confirms the creation of your ASG.

## Destroying the Infrastructure

To clean up and remove all the resources created by Terraform, run the following command:

```sh
terraform destroy -auto-approve
```

This command will automatically destroy all the resources without prompting for confirmation.

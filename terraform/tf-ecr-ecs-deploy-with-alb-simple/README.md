
# Deploying a Python Container Application to AWS ECS using Terraform

## Introduction

In this guide, we'll walk through the steps to deploy a Python container application to Amazon Elastic Container Service (ECS) using Terraform. We will also cover how to push your Docker image to Amazon Elastic Container Registry (ECR). 

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:
- [Terraform](https://www.terraform.io/downloads.html)
- [Docker](https://docs.docker.com/get-docker/)
- AWS CLI configured with appropriate permissions

## Setting up Terraform for ECS

First, we'll set up Terraform configurations to create the necessary ECS infrastructure.

### `main.tf`

```hcl
# main.tf

provider "aws" {
  region = "us-west-2"
}

resource "aws_ecs_cluster" "example" {
  name = "example"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = file("tf-iam-role.json")
}

resource "aws_iam_role_policy" "ecs_task_execution_policy" {
  name   = "ecsTaskExecutionPolicy"
  role   = aws_iam_role.ecs_task_execution_role.id
  policy = file("tf-ecs-task-execution.json")
}

resource "aws_iam_policy" "ecs_policy" {
  name   = "ecsPolicy"
  policy = file("tf-ecs-policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_policy.arn
}
```

### `tf-ecs-task-execution.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
```

### `tf-ecs-policy.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeleteCluster",
        "ecs:DescribeClusters",
        "ecs:RegisterTaskDefinition",
        "ecs:DeregisterTaskDefinition",
        "ecs:CreateService",
        "ecs:UpdateService",
        "ecs:DeleteService",
        "ecs:DescribeServices",
        "ecs:DescribeTaskDefinition",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:PassRole",
        "iam:GetRole",
        "iam:ListRolePolicies",
        "iam:ListInstanceProfilesForRole"
      ],
      "Resource": "*"
    }
  ]
}
```

### `tf-iam-role.json`

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeleteCluster",
        "ecs:DescribeClusters",
        "ecs:RegisterTaskDefinition",
        "ecs:DeregisterTaskDefinition",
        "ecs:CreateService",
        "ecs:UpdateService",
        "ecs:DeleteService",
        "ecs:DescribeServices",
        "ecs:DescribeTaskDefinition",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:AttachRolePolicy",
        "iam:DetachRolePolicy",
        "iam:PassRole",
        "iam:GetRole",
        "iam:ListRolePolicies",
        "iam:ListAttachedRolePolicies"
      ],
      "Resource": "*"
    }
  ]
}
```

## Building and Pushing the Docker Image

Now, let's build the Docker image for our Python application and push it to ECR.

### `app.py`

```python
# app.py

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(host='0.0.0.0')
```

### `Dockerfile`

```Dockerfile
# Dockerfile

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "app.py"]
```

### Steps to Build and Push the Docker Image

1. **Authenticate Docker to ECR**

    ```sh
    aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <your_ecr_registry_url>
    ```

2. **Build the Docker Image**

    ```sh
    docker build -t py-container-app .
    ```

3. **Tag the Docker Image**

    ```sh
    docker tag py-container-app:latest <your_ecr_registry_url>/py-container-app:latest
    ```

4. **Push the Docker Image to ECR**

    ```sh
    docker push <your_ecr_registry_url>/py-container-app:latest
    ```

## Deploying the Application on ECS

With the Docker image pushed to ECR and the ECS infrastructure set up using Terraform, you can now deploy your application.

```sh
terraform init
terraform apply
```

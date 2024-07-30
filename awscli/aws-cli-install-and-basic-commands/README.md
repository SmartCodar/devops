
# Comprehensive Guide to AWS CLI: Managing VPC, EC2, ECS, and ECR

## Introduction

The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services. This guide provides detailed instructions on using the AWS CLI to create and manage AWS resources such as VPCs, Subnets, Route Tables, Security Groups, EC2 instances, ECS clusters, and ECR repositories. We will also cover how to install and configure the AWS CLI v2.

## Installation of AWS CLI v2

### Method 1: Install from Package Manager

#### macOS
```bash
brew install awscli
```

#### Linux
```bash
sudo apt-get update
sudo apt-get install awscli -y
```

### Method 2: Download and Install from URL

#### macOS/Linux
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

#### Windows
```powershell
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile "AWSCLIV2.msi"
Start-Process msiexec.exe -ArgumentList '/i AWSCLIV2.msi /qn' -NoNewWindow -Wait
```

## Configuring AWS CLI

After installation, configure the AWS CLI with your credentials using `aws configure`.

```bash
aws configure
```

You will be prompted to enter your AWS Access Key, Secret Key, region, and output format. Example:

```plaintext
AWS Access Key ID [None]: YOUR_ACCESS_KEY
AWS Secret Access Key [None]: YOUR_SECRET_KEY
Default region name [None]: us-west-2
Default output format [None]: json
```

## Creating AWS Resources

### Create a VPC

The following command creates a VPC with a specified CIDR block. The VPC ID is stored in a variable for later use.

```bash
VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
```

### Create a Subnet

Create a subnet within the VPC. Save the subnet ID for future use.

```bash
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
```

### Create an Internet Gateway

Create an internet gateway and attach it to the VPC.

```bash
IGW_ID=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id $VPC_ID --internet-gateway-id $IGW_ID
```

### Create a Route Table

Create a route table for the VPC and store its ID.

```bash
ROUTE_TABLE_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID --query 'RouteTable.RouteTableId' --output text)
```

### Create a Route to the Internet Gateway

Add a route to the internet gateway in the route table.

```bash
aws ec2 create-route --route-table-id $ROUTE_TABLE_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID
```

### Associate Subnet with Route Table

Associate the subnet with the route table.

```bash
aws ec2 associate-route-table --subnet-id $SUBNET_ID --route-table-id $ROUTE_TABLE_ID
```

### Create a Security Group

Create a security group within the VPC and store its ID.

```bash
SG_ID=$(aws ec2 create-security-group --group-name my-sg --description "My security group" --vpc-id $VPC_ID --query 'GroupId' --output text)
```

### Allow SSH and HTTP Access

Authorize inbound traffic for SSH (port 22) and HTTP (port 80).

```bash
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SG_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
```

### Launch an EC2 Instance

Launch an EC2 instance using the specified AMI, instance type, key pair, security group, and subnet.

```bash
INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0abcd1234efgh5678 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids $SG_ID --subnet-id $SUBNET_ID --query 'Instances[0].InstanceId' --output text)
```

### Create an ECR Repository

Create a repository in Amazon ECR.

```bash
REPO_URI=$(aws ecr create-repository --repository-name my-repo --query 'repository.repositoryUri' --output text)
```

### Authenticate Docker to Your ECR Repository

Retrieve an authentication token and authenticate your Docker client to your registry.

```bash
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin $REPO_URI
```

### Push Docker Image to ECR

Build your Docker image, tag it, and push it to your ECR repository.

```bash
docker build -t my-repo .
docker tag my-repo:latest $REPO_URI:latest
docker push $REPO_URI:latest
```

### Create ECS Cluster

Create a new ECS cluster and store its ARN.

```bash
CLUSTER_ARN=$(aws ecs create-cluster --cluster-name my-cluster --query 'cluster.clusterArn' --output text)
```

### Register Task Definition

Register a new task definition with ECS.

```bash
TASK_DEFINITION=$(aws ecs register-task-definition --family my-task --network-mode awsvpc --container-definitions file://container-definitions.json --requires-compatibilities FARGATE --cpu "256" --memory "512" --query 'taskDefinition.taskDefinitionArn' --output text)
```

### Run Task in ECS

Run a task on the ECS cluster using Fargate launch type.

```bash
aws ecs run-task --cluster $CLUSTER_ARN --launch-type FARGATE --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_ID],securityGroups=[$SG_ID],assignPublicIp=ENABLED}" --task-definition $TASK_DEFINITION
```

## Conclusion

This guide provides a comprehensive overview of using the AWS CLI to manage various AWS services. By following these steps, you can efficiently create and manage your AWS resources directly from the command line, automating and streamlining your cloud operations.

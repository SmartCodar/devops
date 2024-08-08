
# Terraform AWS Authentication

This project demonstrates how to authenticate Terraform with AWS using AWS CLI profiles and IAM roles.

## Table of Contents

1. [Installing AWS CLI](#installing-aws-cli)
2. [Configuring AWS CLI Profile](#configuring-aws-cli-profile)
3. [Using AWS CLI Profiles in Terraform](#using-aws-cli-profiles-in-terraform)
4. [Creating and Using IAM Roles](#creating-and-using-iam-roles)
5. [Attaching IAM Roles to EC2 Instances](#attaching-iam-roles-to-ec2-instances)
6. [Example Terraform Configuration](#example-terraform-configuration)

## Installing AWS CLI

### Linux
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### macOS
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

### Windows
Download the installer from the [AWS CLI Installer for Windows](https://awscli.amazonaws.com/AWSCLIV2.msi) and run the MSI installer.

## Configuring AWS CLI Profile

1. **Configure AWS CLI**:
   ```bash
   aws configure --profile your_profile_name
   ```

2. **Verify AWS Configuration**:
   ```bash
   cat ~/.aws/credentials
   cat ~/.aws/config
   ```

## Using AWS CLI Profiles in Terraform

```hcl
provider "aws" {
  profile = "your_profile_name"
  region  = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

## Creating and Using IAM Roles

1. **Create an IAM Role** in the IAM console with the name \`tf-ec2-role\`.
2. **IAM Role Trust Relationship**:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "Service": "ec2.amazonaws.com"
         },
         "Action": "sts:AssumeRole"
       }
     ]
   }
   ```

## Attaching IAM Roles to EC2 Instances

- Attach the role \`tf-ec2-role\` to your EC2 instance during the launch or via the EC2 console for existing instances.

## Example Terraform Configuration

### Using AWS CLI Configured Profile

```hcl
provider "aws" {
  profile = "your_profile_name"
  region  = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

### Using IAM Role

```hcl
provider "aws" {
  region  = "us-west-2"
  assume_role {
    role_arn     = "arn:aws:iam::123456789012:role/tf-ec2-role"
    session_name = "terraform"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```


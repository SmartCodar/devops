
# Terraform AWS Authentication

Terraform, an open-source infrastructure as code tool, allows users to define and provision data center infrastructure using a high-level configuration language. For authenticating with AWS, Terraform can leverage several methods such as environment variables, shared credentials files, or directly specifying credentials within the configuration files. The most common and secure approach is using environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and optionally `AWS_SESSION_TOKEN`) or the shared credentials file located at `~/.aws/credentials`. Terraform also supports assuming IAM roles by specifying the `role_arn` and `source_profile` in the provider configuration, enabling cross-account access and enhanced security management.

## Best Practices

When configuring AWS authentication in Terraform, it is crucial to follow security best practices to safeguard your AWS resources. Firstly, avoid hardcoding credentials directly within Terraform configuration files, as this poses a significant security risk. Instead, use environment variables or the shared credentials file. Secondly, utilize IAM roles wherever possible, especially for cross-account access, to benefit from temporary security credentials that automatically expire. Regularly rotate your AWS credentials to minimize the risk of compromised access. Lastly, enforce the principle of least privilege by ensuring that the IAM roles and policies used by Terraform have only the necessary permissions required to perform the intended operations.


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


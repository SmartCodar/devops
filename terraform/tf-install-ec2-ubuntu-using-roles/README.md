
# 🚀 Automating Terraform Installation and Configuration on Ubuntu EC2 Server 🚀

## Introduction

### What is Terraform?

**Terraform** is an open-source infrastructure as code (IaC) software tool created by HashiCorp. It allows users to define and provision data center infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL), or optionally JSON. Terraform manages infrastructure by utilizing "providers" for different platforms and services such as AWS, Azure, and Google Cloud.

### What is Infrastructure as Code (IaC)?

**Infrastructure as Code (IaC)** is the process of managing and provisioning computing infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools. This approach enables consistent and repeatable deployments, reducing the risk of human error, and improving scalability and manageability.

### Why Do We Need to Configure Roles?

Configuring roles in AWS ensures that your infrastructure components have the necessary permissions to interact with AWS services securely and efficiently. Using IAM roles over IAM users provides enhanced security and ease of management, especially in automated workflows. Roles enable you to follow the principle of least privilege, granting only the permissions necessary for the tasks at hand.

#### Required Roles and Permissions:

- **AmazonEC2FullAccess**: Provides full access to EC2 resources.
- **AmazonEC2RoleforAWSCodeDeployLimited**: Limited access required for AWS CodeDeploy.
- **AmazonEC2RoleforSSM**: Access to Systems Manager for managing instances.

### Alternatives: AWS CLI vs. IAM Roles

While the AWS CLI can also be used to manage AWS services, IAM roles provide a more secure and scalable way to grant permissions. IAM roles can be assumed by any service that needs access, allowing for better control and security compared to using long-lived AWS CLI credentials.

## Terraform Installation Script

### Description

This shell script automates the installation of Terraform on an Ubuntu EC2 server. It also configures an IAM role with the necessary permissions for managing EC2 instances, CodeDeploy, and SSM.

### Shell Script

```sh
#!/bin/bash

# Update the package list and install dependencies
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common curl

# Add the HashiCorp GPG key
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update the package list again to include the new repository
sudo apt-get update -y

# Install Terraform
sudo apt-get install -y terraform

# Verify the installation
terraform -v

# Configure IAM role permissions
ROLE_NAME="my-tf-server-role"
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://trust-policy.json
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeployLimited
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AmazonEC2RoleforSSM

echo "Terraform installation complete. IAM role configured with necessary permissions."
```

### How to Install and Verify Using the Script

1. **Create an EC2 instance:**
   - Launch an EC2 instance using the AWS Management Console.
   - Ensure the instance has an IAM role with sufficient permissions to execute the script.

2. **SSH into the instance:**
   - Connect to your EC2 instance using SSH.

3. **Create the script:**
   - Copy the shell script content into a file, e.g., `install_terraform.sh`.

4. **Make the script executable:**
   - Run `chmod +x install_terraform.sh` to make the script executable.

5. **Run the script:**
   - Execute the script using `./install_terraform.sh`.

6. **Verify the installation:**
   - The script will automatically install and verify Terraform installation, and configure the IAM role with the necessary permissions.

```sh
chmod +x install_terraform.sh
./install_terraform.sh
```

### Verifying Installation and Configuration

After running the script, you can verify the deployment by:

1. **Checking Terraform Version:**

    ```sh
    terraform -v
    ```

2. **Listing IAM Roles:**

    ```sh
    aws iam list-roles
    ```

3. **Viewing Terraform State:**

    ```sh
    terraform show
    ```


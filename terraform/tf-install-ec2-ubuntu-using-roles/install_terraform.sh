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


# Terraform Configuration Files for Autoscaling and Load Balancing

This repository contains Terraform configuration files for setting up an autoscaling group and a load balancer on AWS. Below is a brief explanation of each file and its usage.

## Files and Usage

### autoscaling.tf
This file contains the configuration for setting up an AWS Autoscaling Group. It defines the launch configuration, scaling policies, and CloudWatch alarms to ensure that your application can scale out and in based on demand.

### load_balancer.tf
This file defines the configuration for setting up an AWS Load Balancer. It includes the target group, listeners, and load balancer itself to distribute incoming traffic across your instances.

### main.tf
The main configuration file that brings together all resources. It includes provider configuration, resource definitions, and calls to the other configuration files.

### outputs.tf
This file defines the outputs of the Terraform run. It specifies which values should be displayed at the end of the `terraform apply` command, such as the DNS name of the load balancer.

### provider.tf
This file specifies the provider configuration, in this case, AWS. It includes the region and any necessary provider-specific settings.

### terraform.tfvars
This file contains the variable definitions that are used to parameterize the Terraform configuration. It includes values for the AWS region, instance type, and other customizable parameters.

### variables.tf
This file defines the variables used throughout the Terraform configuration. It includes default values and descriptions for each variable.

## Scenario

### Create an ASG with EC2 and Load Balancer Target Group Using Terraform

Follow these steps to create an autoscaling group (ASG) with EC2 instances and a load balancer target group using the provided Terraform configuration files.

1. Ensure you have Terraform installed on your machine.
2. Configure your AWS credentials.
3. Clone this repository to your local machine.
4. Navigate to the directory containing the Terraform configuration files.

#### Initialize the Terraform Configuration
Run the following command to initialize the Terraform configuration. This will download the necessary provider plugins and initialize the backend.
   ```
   terraform init
   ```

#### Review the Execution Plan
Generate and review the execution plan to understand what changes Terraform will make to your infrastructure.
   ```
   terraform plan
   ```

#### Apply the Configuration
Apply the Terraform configuration to create the resources. Confirm the prompt with `yes`.
   ```
   terraform apply
   ```

#### View the Outputs
After the apply completes, view the outputs to get the information about the created resources.
   ```
   terraform output
   ```

#### Destroy the Resources
When you no longer need the resources, destroy them to avoid unnecessary charges. Confirm the prompt with `yes`.
   ```
   terraform destroy
   ```

## Requirements

- Terraform 0.12+
- AWS CLI configured with appropriate credentials

## Authors

This configuration is maintained by the DevOps team.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

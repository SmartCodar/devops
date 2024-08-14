terraform {
  backend "s3" {
    bucket         = "tf-s3-511"
    key            = "state/terraform.tfstate"
    region         = "eu-west-3" 
    encrypt        = true
  }
}

module "secgroup" {
  source = "./modules"
  vpc_id = aws_vpc.main.id
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "Hold the value for aws_region"
  type = string
  default = "eu-west-3"
}

output "selected_region" {
  description = "The AWS region selected for deployment"
  value       = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc-with-tf"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-3a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "private-subnet"
  }
}

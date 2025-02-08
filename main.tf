terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

variable "subnet_ip_cidr_range" {
  description = "subnet untuk dev environment"
}

resource "aws_vpc" "development_network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Development Network"
  }
}

resource "aws_subnet" "dev_subnet_01" {
  vpc_id = aws_vpc.development_network.id
  #   availability_zone = "ap-southeast-1"
  cidr_block = var.subnet_ip_cidr_range
  tags = {
    Name = "Dev Subnet 01"
  }
}

output "development_network_id" {
  value = aws_vpc.development_network.id
}

# output "dev_subnet_01_gateway" {
#   value = aws_subnet.dev_subnet_01.gateway_address
# }
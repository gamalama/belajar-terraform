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

resource "aws_vpc" "development_network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Development Network"
  }
}

resource "aws_subnet" "dev_subnet_01" {
  vpc_id            = aws_vpc.development_network.id
#   availability_zone = "ap-southeast-1"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Dev Subnet 01"
  }
}

data "aws_vpc" "existing_default_network" {
    default = true
}

resource "aws_subnet" "dev_subnet_02" {
  vpc_id = data.aws_vpc.existing_default_network.id
  cidr_block = "172.31.64.0/20"
  tags = {
    Name = "Dev Subnet 02"
  }
}
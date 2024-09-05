provider "aws" {
  region = "us-east-1"
  # access_key = "" //set global variable in system 
  # secret_key = "" //set global variable in system 
}

# variable "vpc_cidr_block" {
#   description = "vpc cidr block"
#   default     = "10.0.0.0/16"
#   type = string
# }
variable "cidr_block" {
  description = "vpc cidr block for vpc and sunnet"
  # default     = "10.0.0.0/16"
  type = list(object({
    cidr_block = string,
    name       = string
  }))
}
variable "development" {
  description = "Deployment environment"

}
resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_block[0].cidr_block
  tags = {
    Name : var.development,
    vpc_env : "dev"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.development-vpc.id
  cidr_block        = var.cidr_block[1].cidr_block
  availability_zone = "us-east-1a"
  tags = {
    Name : "subnet-1-dev",
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

variable "subnet_cidr_block" {
  description = "subnet cidr block 172.31.96.0/20"
}
resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1c"
  tags = {
    Name : "subnet-2-default",
  }
}

output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}

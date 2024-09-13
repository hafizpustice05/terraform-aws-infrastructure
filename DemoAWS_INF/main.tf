provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source                 = "./modules/subnet"
  subnet_cidr_block      = var.subnet_cidr_block
  avail_zone             = var.avail_zone
  env_prefix             = var.env_prefix
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  vpc_id                 = aws_vpc.myapp-vpc.id

}

module "webserver" {
  source              = "./modules/webserver"
  avail_zone          = var.avail_zone
  env_prefix          = var.env_prefix
  instance_type       = var.instance_type
  my_ip               = var.my_ip
  image_name          = var.image_name
  subnet_id           = module.myapp-subnet.subnet.id
  public_key_location = var.public_key_location
  vpc_id              = aws_vpc.myapp-vpc.id
}

/*
resource "aws_route_table" "myapp-route-table" {
  vpc_id = aws_vpc.myapp-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name : "${var.env_prefix}-route-table"
  }
}
*/


/*
resource "aws_route_table_association" "a_rtb-subnet" {
  subnet_id      = aws_subnet.dev-subnet-1.id
  route_table_id = aws_route_table.myapp-route-table.id
}
*/


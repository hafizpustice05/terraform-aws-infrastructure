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


# resource "aws_vpc" "myapp-vpc" {
#   cidr_block = var.vpc_cidr_block
#   tags = {
#     Name : "${var.env_prefix}-vpc"
#   }
# }


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "cloud_lab-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.avail_zone, "us-east-1b"]
  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = [var.subnet_cidr_block, "10.0.20.0/24"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  public_subnet_tags = {
    Name : "${var.env_prefix}-pb-subnet-1"
  }

  public_route_table_tags = {
    Name : "${var.env_prefix}-rtb"
  }

  igw_tags = {
     Name : "${var.env_prefix}-igw"
  }
  vpc_tags = {
    Name : "${var.env_prefix}-vpc"
  }
  tags = {
    Name : "${var.env_prefix}"
  }
}




module "webserver" {
  source              = "./modules/webserver"
  avail_zone          = var.avail_zone
  env_prefix          = var.env_prefix
  instance_type       = var.instance_type
  my_ip               = var.my_ip
  image_name          = var.image_name
  public_key_location = var.public_key_location
  subnet_id           = module.vpc.public_subnets[0]
  vpc_id              = module.vpc.vpc_id
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

/*
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
*/
locals {
  vpc_id                     = module.vpc.vpc_id
}
#Create VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                   = "test_project_alarstudios"
  cidr                   = "10.10.0.0/16"
  azs                    = ["us-east-1a", "us-east-1b"]
  public_subnets         = ["10.10.10.0/24", "10.10.30.0/24"]
  private_subnets        = ["10.10.20.0/24", "10.10.40.0/24"]
  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = false
  tags = {
    Name = "test_project_alarstudios"
  }
}
#Main security group
resource "aws_security_group" "main_sg" {
  name        = "main_sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description      = "SSH from anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
#Load balancer security group
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from anywhere"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
#webapp security group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description      = "HTTP from public subnets"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["10.10.10.0/24", "10.10.30.0/24"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.10.10.0/24", "10.10.30.0/24"]
  }
}
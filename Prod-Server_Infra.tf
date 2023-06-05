terraform{
         required_providers {
                 aws = {
                         source = "hashicorp/aws"
                         version = "~> 4.0"
                 }
         }
}

locals {
  security_group_id = "sg-03c8373331e81fb6a"
  vpc_id = "vpc-047b174833ca44699"
  subnet_id = "subnet-0701a949f6a48fe16"
  internet_gateway_id = "igw-03bec895e5bb2ffbb"
}
provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/var/lib/jenkins/workspace/test-server-deployment/config"]
  shared_credentials_files = ["/var/lib/jenkins/workspace/test-server-deployment/credentials"]
}

resource "aws_network_interface" "prod-ni" {
   subnet_id  = local.subnet_id
   private_ips = ["10.0.128.7"]
   security_groups = [local.security_group_id]

}

resource "aws_eip" "prod-eip" {
  vpc  = true
  network_interface = aws_network_interface.prod-ni.id
  associate_with_private_ip = "10.0.128.7"

}

resource "aws_instance" "prod-server" {
  ami                         = "ami-053b0d53c279acc90" #us-east-1
  instance_type               = "t2.micro"
  key_name                    = "AWS_Key"
  availability_zone  = "us-east-1a"


  network_interface {
  network_interface_id = aws_network_interface.prod-ni.id
  device_index = 0
  } 

  tags = { 
    Name = "Prod-Server"
  }

}


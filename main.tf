terraform {
  required_version = ">= 0.12"
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
}

resource "aws_vpc" "tf_anisble_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-anisble"
  }
}

resource "aws_subnet" "tf_anisble_subnet" {
  vpc_id            = aws_vpc.tf_anisble_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-anisble"
  }
}

resource "aws_network_interface" "tf_anisble_ni" {
  subnet_id   = aws_subnet.tf_anisble_subnet.id
  private_ips = ["172.16.10.100", "172.16.10.101"]

  tags = {
    Name = "primary_network_interface"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count = 1

  network_interface {
    network_interface_id = aws_network_interface.tf_anisble_ni.id
    device_index         = 0
  }

  tags = {
    Name  =  "tf-anisble"
    owner =  "Insight-guide"
  }
}


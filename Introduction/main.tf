provider "aws" {
  profile                 = "root"
  shared_credentials_file = "~/.aws/credentials/"
  region                  = "eu-west-2"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "12.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_security_group" "SSHSec" {
  name        = "allow_SSH"
  description = "Allow SSH traffic"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "subnet_one" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "12.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "inter_gate" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "route" {
  route_table_id         = "${aws_route_table.route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.inter_gate.id}"
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subnet_one.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}

resource "aws_instance" "instance_one" {
  ami             = "ami-0917237b4e71c5759"
  instance_type   = "t2.micro"
  key_name        = "firstkey"
  subnet_id       = "${aws_subnet.subnet_one.id}"
  security_groups = ["${aws_security_group.SSHSec.id}"]
}


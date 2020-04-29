resource "aws_vpc" "VPC210120" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_hostnames = true
  tags = {
    Name = "VPC210120"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "publicA" {
  cidr_block        = var.pub-snA-cidr-block
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.VPC210120.id
}

resource "aws_subnet" "publicB" {
  cidr_block        = var.pub-snA-cidr-block_one
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.VPC210120.id
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.VPC210120.id
  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "vpc_rt" {
  vpc_id = aws_vpc.VPC210120.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "Route Table for VPC"
  }
}

resource "aws_route_table_association" "pub_subA_rta" {
  subnet_id      = aws_subnet.publicA.id
  route_table_id = aws_route_table.vpc_rt.id
}
provider "aws" {
  profile                 = "root"
  shared_credentials_file = "~/.aws/credentials/"
  region                  = "${var.aws_region}"
  version                 = "~> 2.0"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_webserver_sg" {
  source = "./SecurityGroups"
  name   = "WebServerSG"
  vpc_id = "${module.aws_vpc.vpc_id}"
}

module "asg" {
  source     = "./ASG"
  vpc_id     = "${module.aws_vpc.vpc_id}"
  subnetA    = "${module.aws_vpc.subnetA}"
  subnetB    = "${module.aws_vpc.subnetB}"
  aws_region = var.aws_region
  image_id   = "${lookup(var.ami, var.aws_region)}"
}

variable "ami_id" {
  default = "ami-0917237b4e71c5759"
}

variable "keyn" {
  default = "firstkey"
}

variable "t2_micro" {
  default = "t2.micro"
}

variable "vpc-cidr-block" {
  description = "CIDR block for VPC"
}

variable "pub-snA-cidr-block" {
  description = "CIDR block for Public Subnet A"
}

variable "pub-snA-cidr-block-one" {
  description = "CIDR block for Public Subnet B"
}
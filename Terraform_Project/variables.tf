variable "ami_id" {
  default = "ami-0917237b4e71c5759"
}

variable "keyn" {
  default = "firstkey"
}

variable "t2_micro" {
  default = "t2.micro"
}

variable "ami" {
  type = map
  default = {
    "eu-west-2"  = "ami-0917237b4e71c5759"
    "eu-west-3"  = "ami-08c757228751c5335"
    "ap-south-1" = "ami-0b44050b2d893d5f7"
  }
}

variable "aws_region" {
}

variable "worker_instance_type" {
  description = "instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnetA" {
  description = "subnet id"
}

variable "subnetB" {
  description = "subnet id"
}

variable "image_id" {
  description = "image_id"
}

variable "aws_region" {}
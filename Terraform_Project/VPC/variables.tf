variable "vpc-cidr-block" {
  description = "CIDR block for VPC"
  default     = "12.0.0.0/16"
}

variable "pub-snA-cidr-block" {
  description = "CIDR block for Public Subnet A"
  default     = "12.0.1.0/24"
}

variable "pub-snA-cidr-block_one" {
  description = "CIDR block for Public Subnet B"
  default     = "12.0.2.0/24"
}
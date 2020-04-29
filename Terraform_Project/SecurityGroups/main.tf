resource "aws_security_group" "wsg" {
  name        = var.name
  description = "Allow SSH connection"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    iterator = x
    for_each = var.ingress_ports
    content {
      from_port   = x.value
      protocol    = "tcp"
      to_port     = x.value
      cidr_blocks = var.open-internet
    }
  }

  egress {
    from_port   = var.outbound-port
    protocol    = "-1"
    to_port     = var.outbound-port
    cidr_blocks = var.open-internet
  }
}

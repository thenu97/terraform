output "vpc_id" {
  value = "${aws_vpc.VPC210120.id}"
}

output "subnetA" {
  value = "${aws_subnet.publicA.id}"
}

output "subnetB" {
  value = "${aws_subnet.publicB.id}"
}

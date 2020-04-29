resource "aws_launch_configuration" "worker" {
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.
  name_prefix = "worker-"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.worker_instance_type}"
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "worker" {
  # Force a redeployment when launch configuration changes.
  # This will reset the desired capacity if it was changed due to
  # autoscaling events.
  name = "${aws_launch_configuration.worker.name}-asg"

  min_size             = 0
  desired_capacity     = 1
  max_size             = 5
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.worker.name}"
  vpc_zone_identifier  = ["${var.subnetA}", "${var.subnetB}"]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "web_group" {
  name_prefix   = "jasons"
  vpc_zone_identifier = [ "${aws_subnet.public-subnet.id}","${aws_subnet.public-subnet-2.id}"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.web-tier.id
    version = "$Latest"
  }

  tag {
    key                 = "tier"
    value               = "web"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "app_group" {
  name_prefix   = "jasons"
  vpc_zone_identifier = [ "${aws_subnet.private-subnet.id}","${aws_subnet.private-subnet-2.id}"]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 1

  launch_template {
    id      = aws_launch_template.app-tier.id
    version = "$Latest"
  }

  tag {
    key                 = "tier"
    value               = "app"
    propagate_at_launch = true
  }

}
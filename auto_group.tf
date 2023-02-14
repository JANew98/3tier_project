resource "aws_autoscaling_group" "web_group" {
  name_prefix   = "jasons"
  vpc_zone_identifier = [ "${aws_subnet.public-subnet.id}","${aws_subnet.public-subnet-2.id}"]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1

  health_check_type    = "ELB"
  lifecycle {
    create_before_destroy = true
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  
  launch_template {
    id      = aws_launch_template.web-tier.id
    version = "$Latest"
  }

  tag {
    key                 = "tier"
    value               = "web"
    propagate_at_launch = true
  }

  tag {
    key = "Name"
    value = "web_instance"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "app_group" {
  name_prefix   = "jasons"
  vpc_zone_identifier = [ "${aws_subnet.private-subnet.id}","${aws_subnet.private-subnet-2.id}"]
  desired_capacity   = 2
  max_size           = 5
  min_size           = 1
  lifecycle {
    create_before_destroy = true
  }

  launch_template {
    id      = aws_launch_template.app-tier.id
    version = "$Latest"
  }

  tag {
    key                 = "tier"
    value               = "app"
    propagate_at_launch = true
  }

  tag {
    key = "Name"
    value = "app_instance"
    propagate_at_launch = true
  }

}
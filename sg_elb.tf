/*resource "aws_elb" "web_elb" {
  name = "web-elb"
  security_groups = [
    "${aws_security_group.elb_sg.id}"
  ]
  subnets = ["${aws_subnet.public-subnet.id}","${aws_subnet.public-subnet-2.id}"]
cross_zone_load_balancing   = true

health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}*/

resource "aws_lb" "web_lb" {
  name               = "my-site-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.elb_sg.id}"]
  subnets            = ["${aws_subnet.public-subnet.id}","${aws_subnet.public-subnet-2.id}"]
}

resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = "${aws_lb.web_lb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_tg.arn}"
  }
}

 resource "aws_lb_target_group" "lb_tg" {
   name     = "lb target group"
   port     = 80
   protocol = "HTTP"
   vpc_id   = "${aws_vpc.tiered_vpc.id}"
 }

resource "aws_autoscaling_attachment" "as_att" {
  autoscaling_group_name = "${aws_autoscaling_group.web_group.id}"
  alb_target_group_arn   = "${aws_lb_target_group.lb_tg.arn}"
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow SSH from Jason"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"

  ingress {
    description      = "ssh_in"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.TF_VAR_my_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_SSH"
  }
}

resource "aws_security_group" "web_in" {
  name        = "allow_ec2"
  description = "web servers to app servers"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"

  ingress {
    description      = "web_in"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = ["${aws_security_group.allow_ssh.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_in"
  }
}

resource "aws_security_group" "app_in" {
  name        = "allow_sql"
  description = "Allow access to database"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"

  ingress {
    description      = "app_in"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = ["${aws_security_group.web_in.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_in"
  }
}

resource "aws_security_group" "bastion_ssh" {
  name        = "bastion-ssh"
  description = "Allow SSH inbound from bastion"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"

  ingress {
    description      = "ssh_in"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = ["${aws_security_group.allow_ssh.id}"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_ssh"
  }
}

resource "aws_security_group" "web_access" {
  name        = "web_access"
  description = "Allow http traffic from the web"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"

  ingress {
    description      = "ssh_in"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_access"
  }
}

# Creating Security Group for ELB
resource "aws_security_group" "elb_sg" {
  name        = "elb security group"
  description = "elb security group"
  vpc_id      = "${aws_vpc.tiered_vpc.id}"
# Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb_sg"
  }
}
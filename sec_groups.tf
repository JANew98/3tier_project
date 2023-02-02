resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.tiered_vpc.id

  ingress {
    description      = "ssh_in"
    from_port        = 22
    to_port          = 22
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
    Name = "allow_SSH"
  }
}

resource "aws_security_group" "web_in" {
  name        = "allow_ec2"
  description = "Allow ec2 to ssh"
  vpc_id      = aws_vpc.tiered_vpc.id

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
  vpc_id      = aws_vpc.tiered_vpc.id

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
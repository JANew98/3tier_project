resource "aws_instance" "bastion" {
  ami = "${data.aws_ami.linux_instance.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-subnet.id}"
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  key_name = "${var.ami_key_pair_name[0]}"
  tags = {
    Name = "bastion_host"
  }

}


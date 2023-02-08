resource "aws_instance" "manager_node" {
  ami = "${data.aws_ami.linux_instance.id}"

  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public-subnet.id}"
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  key_name = "${data.aws_key_pair.test_key.key_name}"
  user_data = "${file("bastion_ud.sh")}"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  tags = {
    Name = "manager_node"
  }

}


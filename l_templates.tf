data "aws_ami" "linux_instance" {
    most_recent = "true"
    owners = ["amazon"]
    filter {
      name = "name"
      values = [ "amzn2-ami-kernel-5.10-hvm-2.0.20230119.1-x86_64-gp2" ]
    }

    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
}

resource "aws_launch_template" "web-tier" {
  name_prefix   = "web-tier"
  image_id      = "${data.aws_ami.linux_instance.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.bastion_ssh.id}", "${aws_security_group.web_access.id}" ]
  key_name = "${data.aws_key_pair.test_key_1.key_name}"

  
}

resource "aws_launch_template" "app-tier" {
  name_prefix   = "app-tier"
  image_id      = "${data.aws_ami.linux_instance.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ "${aws_security_group.web_in.id}","${aws_security_group.bastion_ssh.id}" ]
  key_name = "${data.aws_key_pair.test_key_1.key_name}"
  
}


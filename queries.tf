data "aws_key_pair" "test_key" {
    filter {
      name = "tag:targets"
      values = [ "bastion" ]
    }
}

data "aws_key_pair" "test_key_1" {
    filter {
      name = "tag:targets"
      values = [ "nodes" ]
    }
}
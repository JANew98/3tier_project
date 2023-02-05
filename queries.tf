data "aws_key_pair" "test_key" {

    filter {
      name = "tag:target"
      values = [ "bastion" ]
    }
}

data "aws_key_pair" "test_key_1" {
    
    filter {
      name = "tag:target"
      values = [ "nodes" ]
    }
}
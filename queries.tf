data "aws_key_pair" "test_key" {
    name = "terraform_key"
    
    filter {
      name = "tag:targets"
      values = [ "bastion" ]
    }
}

data "aws_key_pair" "test_key_1" {
    name = "ansikey"
    
    filter {
      name = "tag:targets"
      values = [ "nodes" ]
    }
}
data "aws_key_pair" "test_key" {
    key_name = "terraform_key"
    
    filter {
      name = "tag:targets"
      values = [ "bastion" ]
    }
}

data "aws_key_pair" "test_key_1" {
    key_name = "ansikey"
    
    filter {
      name = "tag:targets"
      values = [ "nodes" ]
    }
}
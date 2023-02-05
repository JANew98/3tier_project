variable "AWS_REGION" {
    default = "eu-west-2"
}

variable "ami_key_pair_name" {
  type = list(string)
    default = ["terraform_key","ansikey"]
}

variable "TF_VAR_my_ip" {
  default = ""
}


/*cidr_blocks = [
      "${chomp(var.TF_VAR_my_ip)}/32"
    ]*/
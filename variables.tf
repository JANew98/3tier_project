variable "AWS_REGION" {
    default = "eu-west-2"
}

variable "ami_key_pair_name" {
  type = list(string)
    default = ["terraform_key","ansikey"]
}


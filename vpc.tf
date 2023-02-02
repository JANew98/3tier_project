data "aws_availability_zones" "available" {}

resource "aws_vpc" "tiered_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "3tier-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.tiered_vpc.id
  cidr_block = "10.0.${10}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true" 

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.tiered_vpc.id
  cidr_block = "10.0.${43}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[2]}"
  map_public_ip_on_launch = "true" 

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.tiered_vpc.id
  cidr_block = "10.0.${20}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}" 

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.tiered_vpc.id
  cidr_block = "10.0.${30}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[2]}" 

  tags = {
    Name = "private-subnet-2"
  }
}
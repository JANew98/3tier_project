resource "aws_internet_gateway" "prod-igw" {
    vpc_id = "${aws_vpc.tiered_vpc.id}"
    
    tags = {
    Name = "prod-igw"
  }
}

resource "aws_route_table" "test_route" {
    vpc_id = "${aws_vpc.tiered_vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.prod-igw.id}"
    }

    tags = {
        Name = "test_route"
    }
}

resource "aws_route_table_association" "pubsubnet-association"{
    subnet_id = "${aws_subnet.public-subnet.id}"
    route_table_id = "${aws_route_table.test_route.id}"
}

resource "aws_route_table_association" "pubsubnet-1-association"{
    subnet_id = "${aws_subnet.public-subnet-2.id}"
    route_table_id = "${aws_route_table.test_route.id}"
}


resource "aws_eip" "nate_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "prod_nat" {
  connectivity_type = "public"
  subnet_id = "${aws_subnet.public-subnet.id}"
  allocation_id = "${aws_eip.nate_gateway.id}"

}

resource "aws_route_table" "nat_route" {
  vpc_id = "${aws_vpc.tiered_vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_nat_gateway.prod_nat.id}"
    }

    tags = {
        Name = "nat_route"
    }
}

resource "aws_route_table_association" "nat-association"{
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.nat_route.id}"
}

resource "aws_route_table_association" "nat-association-2"{
    subnet_id = "${aws_subnet.private-subnet-2.id}"
    route_table_id = "${aws_route_table.nat_route.id}"
}
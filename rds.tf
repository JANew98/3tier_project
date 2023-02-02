resource "aws_db_subnet_group" "rds_group" {
  name = "my_subnet_group"
  subnet_ids = [ "${aws_subnet.private-subnet.id}","${aws_subnet.private-subnet-2.id}" ]

  tags = {
    "Name" = "My DB subnet group"
  }
}

resource "aws_db_instance" "my_rds" {
    engine = "mysql"
    engine_version = "8.0.28"
    instance_class = "db.t3.micro"
    storage_type = "gp2"
    allocated_storage = "20"
    username = "admin"
    password = "password123"
    publicly_accessible = false
    skip_final_snapshot = true
    db_subnet_group_name = "${aws_db_subnet_group.rds_group.name}"
    vpc_security_group_ids = [ "${aws_security_group.app_in.id}" ]

    tags = {
      "Name" = "Mydb"
    }
  
}
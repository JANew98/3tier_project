#! /bin/bash
sudo yum update -y
sudo yum update httpd
sudo yum install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl restart httpd
sudo yum install git


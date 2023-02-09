#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo pip3 install boto3
sudo amazon-linux-extras install epel -y
sudo yum repolist
sudo yum-config-manager --enable epel
sudo amazon-linux-extras disable ansible2
sudo ansible-galaxy collection install amazon.aws -y
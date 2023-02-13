#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
sudo pip3 install boto3 --user
sudo ansible-galaxy collection install amazon.aws
pip3 install botocore

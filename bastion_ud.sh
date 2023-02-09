#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
sudo ansible-galaxy collection install amazon.aws -y
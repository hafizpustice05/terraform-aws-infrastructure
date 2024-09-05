#!/bin/bash
sudo yum update && sudo yum install -y docker
sudo systemctl status docker.service
sudo usermod -aG docker ec2-user
docker run -p 8080:80 nginx
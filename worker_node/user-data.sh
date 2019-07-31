#!/bin/bash
apt-get update -y
apt-get install -y apache2
systemctl enable apache2@.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html
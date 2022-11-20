#!/usr/bin/bash

# Made with the help of Github Copilot

#Variables
PACKAGES="apache2 bind9 bind9utils bind9-doc"

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

# Update the system
echo "Updating the system..."
apt update
apt upgrade -y
apt install $PACKAGES -y
echo "System updated"

# Backup bind9
echo "Backing up bind9..."
tar -czf /backup/bind9-$(date +%Y-%m-%d).tar.gz /etc/bind
echo "Bind9 backed up"



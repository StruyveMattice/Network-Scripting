#!/usr/bin/bash

# Made with the help of Github Copilot

PATH="/etc/dhcp/dhcpd.conf"

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

# Check if parameter is given
if [ -z "$1" ]
  then echo "No parameter given"
  echo "Enter the dhcp ranges file path"
  exit
fi

# Check if dhcp server is installed
if [ ! -f $PATH ]
  then echo "DHCP server is not installed"
  echo "installing DHCP server..."
  apt install isc-dhcp-server
  exit
fi

# Appending ranges to dhcpd.conf
echo "Appending ranges to dhcpd.conf..."
cat $1 >> $PATH
echo "Ranges appended"


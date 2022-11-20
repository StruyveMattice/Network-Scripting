#!/usr/bin/bash

# Made with the help of Github Copilot

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

# Check if parameter is given
if [ -z "$1" ]
  then echo "No parameter given"
  echo "enter: static or dhcp"
  exit
fi

if [ "$1" == "static" ]
then
    echo "IP Address [blank=192.168.1.100]: "
    read IP
    #check if ip is blank
    if [ -z "$IP" ]
    then
        IP="192.168.1.100"
    fi

    echo "Subnet Mask [blank=255.255.255.0]: "
    read MASK
    #check if mask is blank
    if [ -z "$MASK" ]
    then
        MASK="255.255.255.0"
    fi

    echo "Gateway [blank=192.168.1.1]: "
    read Gateway
    #check if gateway is blank
    if [ -z "$GATEWAY" ]
    then
        GATEWAY="192.168.1.1"
    fi

    echo "Setting static IP"
    # Set static IP
    printf "# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).\n
source /etc/network/interfaces.d/*\n
# The loopback network interface
auto lo
iface lo inet loopback\n
# The primary network interface
allow-hotplug ens33
iface ens33 inet static
        address $IP
        netmask $MASK
        gateway $GATEWAY" > /etc/network/interfaces
    
    sleep 2

    # Restart network
    echo "Static IP set"
    echo "Restarting network"
    eval "/etc/init.d/networking restart"
    eval "systemctl restart networking"
    eval "ifup ens33"

elif [ "$1" == "dhcp" ]
then
    echo "Setting DHCP"
    # Set DHCP
    printf "# This file describes the network interfaces available on your system
    # and how to activate them. For more information, see interfaces(5).
    source /etc/network/interfaces.d/*
    # The loopback network interface
    auto lo
    iface lo inet loopback\n
    # The primary network interface
    allow-hotplug ens33
    iface ens33 inet dhcp" > /etc/network/interfaces
    
    sleep 2

    # Restart network
    echo "DHCP set"
    echo "Restarting network"
    eval "/etc/init.d/networking restart"
    eval "systemctl restart networking"
    eval "ifup ens33"

else
    echo "Invalid parameter"
    echo "enter: static or dhcp"
fi
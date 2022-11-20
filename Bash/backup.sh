#!/usr/bin/bash

# Made with the help of Github Copilot

#Variables
DATE=$(date +%Y-%m-%d)

# Check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

# Check if parameter is given
if [ -z "$1" ]
  then echo "No parameter given"
  echo "enter a folder path"
  exit
fi

# Check if folder exists
if [ ! -d $1 ]
  then echo "Folder does not exist"
  echo "enter a valid folder path"
  exit
fi

# Check if backup folder exists
if [ ! -d "/backup" ]
  then echo "Folder does not exist, creating backup folder..."
  mkdir /backup
  exit
fi
else  
  echo "Folder exists, continuing..."
fi

#Creating backup
echo "Creating backup..."
tar -czf /backup/backup-$DATE.tar.gz $1
echo "Backup created"
#!/usr/bin/bash

# Made with the help of Github Copilot

#Variables
CERT="/cert/crts.txt"
EXPIRE="/cert/expire.txt"

#check if script is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root"
  exit
fi

#Check if cert folder exists    
if [ ! -d "/cert" ]
  then echo "Folder does not exist, creating cert folder..."
  mkdir /cert
  exit
fi
else  
  echo "Folder exists, continuing..."
fi

#Check if crts.txt exists
if [ ! -f $CERT ]
  then echo "File does not exist, creating crts.txt..."
  touch $CERT
  exit
fi
else  
  echo "File exists, continuing..."
fi

#Check if expire.txt exists
if [ ! -f $EXPIRE ]
  then echo "File does not exist, creating expire.txt..."
  touch $EXPIRE
  exit
fi
else  
  echo "File exists, continuing..."
fi

find / -type f -name '*.crt' >>$CERT

FILE=$(cat $CERT)

for l in $FILE; do
  DATE=$(openssl x509 -enddate -noout -in $l)

  YEAR=${DATE:25:-4}
  MONTH=${DATE:9:-21}
  DAY=${DATE:13:-18}

  NEWDATE="$DAY-${MONTH^^}-$YEAR"

  EXPIREDATE=$(date -d "$NEWDATE" +"%s")
  DATEPLUS=$(date -d "$dt +14 day" +"%s")
  CURRENTDATE=$(date +%s)

  if [ "$DATEPLUS" -gt "$EXPIREDATE" ] && [ "$EXPIREDATE" -ge "$CURRENTDATE" ]; then
    echo "$l" >>$EXPIRED
    echo "$l"
  fi
done

# Remove cert file
rm -d $CERT
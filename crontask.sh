#!/bin/bash

#Create tmp folder
if [ ! -d /tmp/activeTables ]; then
    mkdir /tmp/activeTables
fi
cd /tmp/activeTables
wget -Nq https://www.dshield.org/block.txt -O /tmp/activeTables/block.txt
wget -Nq https://www.dshield.org/block.txt.asc -O /tmp/activeTables/block.txt.asc
gpg --no-default-keyring --keyring /tmp/activeTables/dshield.asc --verify block.txt.asc block.txt > /dev/null 2>&1

if [ $? -ne 0 ]; then
    #Verification failed!
    exit 1;
fi

#ipset create activeTable_tmp hash:net
#cat block.txt | grep -P '^[^#S]' | awk '{print $1 "/" $3}' | xargs -0 -I ip -n 1 -d "\n" ipset add activeTalbe_tmp ip
#ipset swap activeTable activeTable_tmp
#ipset destroy activeTable_tmp
#

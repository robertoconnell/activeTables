#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script requires root access to function."
    exit 1
fi
(which ipset >/dev/null && echo "IPset is installed.") || (echo "Install IPset, it should be in your distrobution's repositories." && exit 1)
if [ ! -d /tmp/activeTables ]; then
    mkdir /tmp/activeTables
fi
if ipset list | grep activeTable >/dev/null; then 
    echo "activeTable already exists." 
else 
	echo "Creating ipset table 'activeTable'" 
	ipset create activeTable nethash
fi
#cd /tmp/activeTables
#echo "Downloading blocklist from dshield.org"
#wget -Nq https://www.dshield.org/block.txt -O /tmp/activeTables/block.txt
#cat block.txt | grep -P '^[^#S]' | awk '{print $1 "/" $3}' # | xargs -0 -I ip -n 1 -d "\n" ipset add bad_nets ip


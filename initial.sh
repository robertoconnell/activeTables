#!/bin/bash
if [[ $EUID -ne 0 ]]; then
    echo "This script requires root access to function."
    exit 1
fi
which ipset >/dev/null

if [ $? -eq 0 ]; then
    echo "IPset is installed."
else
    echo "Install IPset, it should be in your distrobution's repositories."; exit 1
fi

if [ ! -d /tmp/activeTables ]; then
    mkdir /tmp/activeTables
fi
if ipset list | grep activeTable >/dev/null; then 
    echo "activeTable already exists." 
else 
	echo "Creating ipset table 'activeTable'" 
	ipset create activeTable nethash
fi
echo "iptables -I OUTPUT -m set --match-set activeTable dst -j REJECT "

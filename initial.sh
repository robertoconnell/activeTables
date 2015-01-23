#!/bin/bash
#Ensure running as root
if [[ $EUID -ne 0 ]]; then
    echo "[x]This script requires root access to function."
    exit 1
fi
#Ensure ipset is installed
which ipset >/dev/null
if [ $? -eq 0 ]; then
    echo "[*]IPset is installed."
else
    echo "[x]Install IPset, it should be in your distrobution's repositories."; exit 1
fi
#Ensure gpg is installed
gpg --version > /dev/null
if [ $? -eq 0 ]; then
    echo "[*]GPG is installed"
else
    echo "[x]Install GPG, it should be in your distrobution's repositories."; exit 1
fi
ipset list activeTable >/dev/null
if [ $? -eq 0]; then 
    echo "[*]activeTable already exists." 
else 
	echo "[*]Creating ipset table 'activeTable'" 
	ipset create activeTable hash:net
fi
echo "iptables -I OUTPUT -m set --match-set activeTable dst -j REJECT "

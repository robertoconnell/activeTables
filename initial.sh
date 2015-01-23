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
ipset list activeTable > /dev/null
if [ $? -eq 0 ]; then 
    echo "[*]activeTable already exists." 
else 
	echo "[*]Creating ipset table 'activeTable'" 
	ipset create activeTable hash:net
fi
echo 'About to run "iptables -I INPUT -m set --match-set activeTable dst -j REJECT"'
echo "Which will add the ipset to your IPTables."
echo "Unless you have some special and fragile iptables setup, this should be fine."
read -p "Continue? [y/N]: " prompt
case $prompt in
    y|Y|yes|Yes ) ;;
    * ) echo "[x]Not adding the ipset to iptables, you'll need to configure that yourself"; exit 1;;
esac
iptables -I INPUT -m set --match-set activeTable dst -j REJECT

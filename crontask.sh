#!/bin/bash
cd /tmp/activeTables
wget -Nq https://www.dshield.org/block.txt -O /tmp/activeTables/block.txt
cat block.txt | grep -P '^[^#S]' | awk '{print $1 "/" $3}' # | xargs -0 -I ip -n 1 -d "\n" ipset add bad_nets ip


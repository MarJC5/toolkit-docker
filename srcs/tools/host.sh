#!/bin/bash

set -e

# Variables
ENV_PATH=.env

# Search first occurrence of a DOMAIN in .env and save value to variable without quotes
DOMAIN=$(grep -m1 DOMAIN $ENV_PATH | cut -d '=' -f2 | sed 's/"//g') 

# Add the domain to the /etc/hosts file if it doesn't already exist
if ! grep "$DOMAIN" /etc/hosts; then
    sudo -- sh -c -e "printf '127.0.0.1\t%-30s\n' ${DOMAIN} >> /etc/hosts" # IPv4
    sudo -- sh -c -e "printf '::1\t\t%-30s\n' ${DOMAIN} >> /etc/hosts" # IPv6
    sudo -- sh -c -e "printf '127.0.0.1\t%-30s\n' www.${DOMAIN} >> /etc/hosts" # IPv4
    sudo -- sh -c -e "printf '::1\t\t%-30s\n' www.${DOMAIN} >> /etc/hosts" # IPv6
    cat /etc/hosts
else
    echo "$DOMAIN Host already existing in /etc/hosts"
fi
#!/bin/bash

release=$(lsb_release -r | awk '{print $2}')

if [[ ${release} < "16.04" ]]; then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ECDCAD72428D7C01 
else
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ECDCAD72428D7C01 
fi

codename=$(lsb_release -c | awk  '{print $2}')
sudo tee /etc/apt/sources.list.d/ddebs.list << EOF
deb http://ddebs.ubuntu.com/ ${codename}      main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-security main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-updates  main restricted universe multiverse
deb http://ddebs.ubuntu.com/ ${codename}-proposed main restricted universe multiverse
EOF

sudo apt-get update
sudo apt-get install -y linux-image-$(uname -r)-dbgsym
sudo apt-get install -y systemtap gcc

#!/bin/bash
set -x
#sudo systemctl start dhcpcd
sudo cp /etc/resolv.conf.bak /etc/resolv.conf
#sudo netctl start wlp2s0-myfuckingwifi
sudo cpu-speed performance
sudo cpu-speed-frequency fast
if [[ ! -z "$1" && "$1" = @(tor) ]] ;then
 sudo systemctl start tor.service
fi
startx ./.xinitrc

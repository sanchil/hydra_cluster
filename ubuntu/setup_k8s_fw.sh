#!/bin/bash

echo "Activating relevant firewall ports for docker and kubernetes:  "

sudo echo "192.168.58.100  k8master.org k8master.org" >> /etc/hosts
sudo echo "192.168.58.101  k1.org k1.org" >>/etc/hosts
sudo echo "192.168.58.102  k2.org k2.org" >>/etc/hosts
sudo ufw allow ssh
sudo ufw allow proto tcp from any to any port 22,80,443,2377,7946,6443,2379:2380,10250:10252,30000:32767,3000:15000
sudo ufw allow proto udp from any to any port 22,80,443,7946,4789
sudo echo "y" | ufw enable

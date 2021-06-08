#!/bin/bash

echo "Switching off swap by default "

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
#sudo touch /etc/profile.d/k8.sh
sudo echo "swapoff -a" >>/etc/profile.d/k8.sh

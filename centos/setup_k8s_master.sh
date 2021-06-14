#!/bin/bash

echo "advertise server used: " $1

sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$1

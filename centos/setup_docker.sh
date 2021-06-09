#!/bin/bash

sudo swapoff -a


sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker-ce docker-ce-cli containerd.io

sudo yum install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo groupadd docker
sudo usermod -aG docker $USER



#sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

#sudo systemctl enable docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo systemctl daemon-reload
sudo systemctl restart docker

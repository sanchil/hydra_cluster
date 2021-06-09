#!/bin/bash

sudo apt-get update
sleep 3

#sudo apt-get install -y openssh-server
#sudo service ssh start
#sudo systemctl status ssh
#sudo ufw allow ssh
#sudo ufw enable
#sudo ufw status

#sleep 3

sudo swapoff -a

sleep 3
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sleep 5
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 2
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 2

#sudo apt-get update
#apt-cache madison docker-ce
# 5:19.03.0~3-0~ubuntu-bionic
# 5:19.03.15~3-0~ubuntu-bionic

sudo apt-get update
sudo apt-get install -y docker-ce=5:19.03.15~3-0~ubuntu-bionic docker-ce-cli=5:19.03.15~3-0~ubuntu-bionic containerd.io
#DOCKER_VER = $(apt-cache madison docker-ce | grep 19.03 | head -1 | awk '{print $3}')
#echo $(DOCKER_VER)
#sudo apt-get install -y docker-ce=$(DOCKER_VER) docker-ce-cli=$(DOCKER_VER) containerd.io

sleep 1

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

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

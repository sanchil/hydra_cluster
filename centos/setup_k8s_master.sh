#!/bin/bash

echo "advertise server used: " $1

sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$1

#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

#or

#export KUBECONFIG=/etc/kubernetes/admin.conf
#echo "creating calico network"


#kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
#kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
#kubectl taint nodes --all node-role.kubernetes.io/master-

##watch kubectl get pods -n calico-system
#kubectl get nodes -o wide



# echo "export HOME=$HOME" >> /home/vagrant/.profile
# echo "export ID=$ID" >> /home/vagrant/.profile
# echo "export GRP=$GRP" >> /home/vagrant/.profile
# kubeadm token create --print-join-command  >> /vagrant/setup_k8s_nodes_join.sh
# kubeadm token create --print-join-command  > /vagrant/nodes_join
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $ID:$GRP $HOME/.kube/config
# kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
# kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml
# sudo apt-get install bash-completion vim -y
# echo 'alias k=kubectl' >> $HOME/.bashrc
# echo "source <(kubectl completion bash)" >> $HOME/.bashrc
# source .bashrc   

# calico
# https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises

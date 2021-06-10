# hydra_cluster

A k8s local cluster for laptops and desktops. This k8s cluster may be run locally from with a laptop or desktop environment. 
It makes use of Calico for implementation of the default CNI plugin for Kubernetes pods. Depending upon needs it may also be used
to connect to GKE instances running on google cloud.

## Why run a local k8s cluster ?

Having kubernetes cluster running locally is a great option as a learning tool. It introduces the user to cluster setup and 
running issues and ways to troubleshoot them and fine tune cluster performance. A minor inconvenience for a great learning experience. 
In addition it also introduces transparency into the cluster setup process.

All the standard scripts for building docker and kubernetes have been collected bound together under the automation umbrella of vagrant via Vagranfile.
Everything that can be configured is configurable via the scripts that vagrant executes.

Additionally this cluster may also be hooked up your cluster running on cloud. It is possible to manage cloud clusters as long as the 
kubectl tool is pointed to the correct cloud config file.


## Pre Requisites

Must have the following installed on your environment

Git (linux/windows/osx)

Virtualbox [https://www.virtualbox.org/]

Vagrant [https://www.vagrantup.com/]


### For Ubuntu

OS image: ubuntu/bionic
master node: k8master
worker node: k1
worker node: k2

```sh
$ git clone https://github.com/sanchil/hydra_cluster.git
$ cd hydra_cluster
$ git checkout ubuntu
```
More information on this page 

[More information for Ubuntu/Bionic](../ubuntu/README.md)

### For Centos 

OS image: centos/8
master node: cent-k8master
worker node: cent-k1
worker node: cent-k2

The worker nodes need to be joined master node by running the join link command copied to  /vagrant/centos_nodes_join file

```sh
$ git clone https://github.com/sanchil/hydra_cluster.git
$ cd hydra_cluster
$ git checkout centos
```

[More information for Centos/8](../centos/README.md)

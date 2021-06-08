# hydra_cluster

A k8s local cluster for laptops and desktops for Ubuntu image.

By default the cluster boots up with following three nodes. 

master node: k8master
worker node: k1
worker node: k2


## A Quick install and check

Follow these commands for a quick download, install and run the cluster.

```sh

$ git clone https://github.com/sanchil/hydra_cluster.git
$ cd hydra_cluster
$ git checkout ubuntu

```

### Vagrant commands

From within ubuntu folder

#### To boot the cluster

Note: The same command is used for boot up the cluster for the first time and each time subsequently


```sh
$ cd ubuntu
$ vagrant up
```


#### To halt the cluster

```sh
$ vagrant halt
```


#### To destroy the cluster

```sh
$ vagrant destroy
```

#### To login to the main control plane, k8master


```sh

$ vagrant ssh k8master

```
The kubectl command is aliased to k. So you may use either k or kubectl to run your kubectl commands.

Run a get nodes command to ensure that all the three nodes, k8master, k1 and k2 are in a running state. The cluster nodes may take some time to come into a ready state. On occassions it my take as long as 10 minutes so give it some time before a conclusion.

```sh

$ k get nodes -o wide

```

Make a quick check if all the pods in namespace kube-system are in a proper running state. All the pods in this namespaces must be in a proper running state. If not, then run a vagrant destroy command and try to bring them up again. If things do not go as planned try switching to a different CNI such as weavenet and giving it a try again. 

Note: You may need to delete calico cni configurations in /etc/cni/net.d and plugins /opt/cni/bin

```sh

$ k get -n kube-system get pods

```
Run an image say redis to ensure that the nodes are able to handle the pods.

```sh

$ k run red --image redis

```

Run kubectl command to check if the pod is running


```sh

$ k get po red -o wide

```
Run describe command on red pod to check the details of the pod.

```sh

$ k describe po red

```

#### To login to k1 worker node

```sh

$ vagrant ssh k8master

```

#### To login to k2 worker node

```sh

$ vagrant ssh k8master

```

## Vagrantfile

The vagrantfile is a simple and a standard straight forward file for building a VM using Virtualbox as its vm platform and ubuntu as its os image.
It runs separate scripts for docker, kubernetes, firewall and swap. All the scripts collections of standards commands and procedures for installing
configuring of vm as per requirements of docker and kubernetes. It makes use of calico as its CNI plugin for implementing of pod networks.

These defaults can be changed either the vagrant file or withing the accompanying setup scripts.

### CNI: Calico

It uses calico to implement the CNI for pod networking.

[ https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises ]

Using the following option to install Calico with Kubernetes API datastore, 50 nodes or less
This is 
```sh
$ curl https://docs.projectcalico.org/manifests/calico.yaml -O
$ kubectl apply -f calico.yaml
```



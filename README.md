# hydra_cluster

A k8s local cluster for laptops and desktops for Ubuntu image.

By default the cluster boots up with following three nodes. 

- master node: k8master
- worker node: k1
- worker node: k2


## A quick install and check

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
#### To login to k1 worker node

```sh

$ vagrant ssh k1

```

#### To login to k2 worker node

```sh

$ vagrant ssh k2

```

#### To test pods and services

Run and nginx pod and a node port service on 30010

curl the pod on the pod ip address, nodeport ip address and node ip and nodeport number

Run nginx image to ensure that the nodes are able to handle the pods.

```sh

$ k run nginx --image nginx --port 80

```

Run kubectl command to check if the pod is running


```sh

$ k get po nginx -o wide

```
Note the ip address of the pod

```sh
NAME   READY   STATUS    RESTARTS   AGE   IP             NODE   NOMINATED NODE   READINESS GATES
nginx  1/1     Running   0          20m   192.168.99.1   k2     <none>           <none>
```

Run describe command on nginx pod to check the details of the pod.

```sh

$ k describe po nginx

```
curl to the ip address and port

```sh
curl http://192.168.99.1:80
```

Create a nodeport service

```sh

k create svc nodeport nginx --tcp=80:80 --node-port=30010 --dry-run=client -o yaml | \
k set selector "run=nginx" --local -f - -o yaml | k create -f -

```

check the node port service ip address

```sh
curl http://<svc_ip>:80

```

Check for the nginx pod running on node ip and node port 30010  

```sh
curl http://<node_ip>:30010

```

Alternatively you may also point your browser to this ip address. 


## Vagrantfile

The vagrantfile is a simple and a standard straight forward file for building a VM using Virtualbox as its vm platform and ubuntu as its os image.
It runs separate scripts for docker, kubernetes and swap. All the scripts collections of standards commands and procedures for installing
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


=======
A k8s local cluster for laptops and desktops. This k8s cluster may be run locally from with a laptop or desktop environment. 
It makes use of Calico for implementation of the default CNI plugin for Kubernetes pods. Depending upon needs it may also be used
to connect to GKE instances running on google cloud.

## Why a local k8s cluster

Having kubernetes cluster running locally is a great option as a learning tool. It introduces the user to cluster setup and 
running issues and ways to troubleshoot them and fine tune cluster performance. A minor inconvenience for a great learning experience. 
In addition it also introduces transparency into the cluster setup process.

All the standard scripts for building docker and kubernetes have been collected bound together under the automation umbrella of vagrant via Vagranfile.
Everything that can be configured is configurable via the scripts that vagrant executes.

Additionally this cluster may also be hooked up your cluster running on cloud. It is possible to manage cloud clusters as long as the 
kubectl tool is pointed to the correct cloud config file.

Ubuntu works at the moment and support for centos will also be added soon.

## Pre Requisites

Must have the following installed on your environment

Git (linux/windows/osx)

Virtualbox [https://www.virtualbox.org/]

Vagrant [https://www.vagrantup.com/]


### For Ubuntu


```sh
$ git clone https://github.com/sanchil/hydra_cluster.git
$ cd hydra_cluster
$ git checkout ubuntu
```


### For Centos [Work in Progress]

Similar steps, but please do wait up for a while for centos.
>>>>>>> e792386f3a79e300550776de57cda0bdf5237d60

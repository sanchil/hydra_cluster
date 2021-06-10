# hydra_cluster

A k8s local cluster for laptops and desktops based on Centos 8 image.

By default the cluster boots up with following three nodes. 

- master node: cent-k8master
- worker node: cent-k1
- worker node: cent-k2

Please note that you will need to manually join the nodes to the master via a join link. This join link can be found /vagrant/centos_nodes_join file on the master node cent-k8master.

## A quick install and check

Follow these commands for a quick download, install and run the cluster.

```sh

$ git clone https://github.com/sanchil/hydra_cluster.git
$ cd hydra_cluster
$ git checkout centos

```

### Vagrant commands

From within centos folder

#### To boot the cluster

Note: The same command is used for boot up the cluster for the first time and each time subsequently


```sh
$ cd centos
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

$ vagrant ssh cent-k8master

```
The kubectl command is aliased to k. So you may use either k or kubectl to run your kubectl commands.

Run a get nodes command to ensure that all the three nodes, cent-k8master, cent-k1 and cent-k2 are in a running state. The cluster nodes may take some time to come into a ready state. On occassions it my take as long as 10 minutes so give it some time before a conclusion.

```sh

$ k get nodes -o wide

```

Make a quick check if all the pods in namespace kube-system are in a proper running state. All the pods in this namespaces must be in a proper running state. If not, then run a vagrant destroy command and try to bring them up again. If things do not go as planned try switching to a different CNI such as weavenet and giving it a try again. 

Note: You may need to delete calico cni configurations in /etc/cni/net.d and plugins /opt/cni/bin

```sh

$ k get -n kube-system get pods

```
#### Copy the master node join link

The join link was copied to /vagrant/centos_nodes_join file. Copy this link and save it.

```sh

$ /vagrant/centos_nodes_join

```

Following are some other ways to recover a join link for the nodes from the master node. On the master node run the following command. Usually you will not need these additional steps.

```sh

$ kubeadm token create --print-join-command

```
or


step-1: 

```sh

$ openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt \
    | openssl rsa -pubin -outform der 2>/dev/null \
    | openssl dgst -sha256 -hex \
    | sed 's/^.* //'

```



step-2: 

```sh
$ kubeadm token list  | awk '{print $1}' | tail -n1
```

step-3: 

Form a join link and run this on worker nodes only


```sh

$ kubeadm join <ip-address>:6443\
    --token=<token-from-step-2> \
    --discovery-token-ca-cert-hash sha256:<ca-hash-from-step-1>
  

```



#### To login to k1 worker node

```sh

$ vagrant ssh cent-k1

```

Join this node by running the join link command found in the /vagrant/centos_nodes_join file in master node. Copy this command and run this as sudo.

```sh

$ sudo kubeadm join <ip-address>:6443\
    --token=<token-from-step-2> \
    --discovery-token-ca-cert-hash sha256:<ca-hash-from-step-1>

```



#### To login to k2 worker node

```sh

$ vagrant ssh cent-k2

```
Join this node by running the join link command as sudo using the same process as used to join node cent-k1


```sh

$ sudo kubeadm join <ip-address>:6443\
    --token=<token-from-step-2> \
    --discovery-token-ca-cert-hash sha256:<ca-hash-from-step-1>

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

```sh
$ curl https://docs.projectcalico.org/manifests/calico.yaml -O
$ kubectl apply -f calico.yaml
```

A k8s local cluster for laptops and desktops. This k8s cluster may be run locally from with a laptop or desktop environment. 
It makes use of Calico for implementation of the default CNI plugin for Kubernetes pods. Depending upon needs it may also be used
to connect to GKE instances running on google cloud.

[Back to Main](../main/blob/README.md)




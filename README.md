# hydra_cluster

A k8s local cluster for laptops and desktops for Ubuntu image.


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

Run a get nodes command to ensure that all the three nodes, k8master, k1 and k2 are in a running state.

```sh

$ k get nodes -o wide

```

Make a quick check if all the pods in namespace kube-system are in a proper running state

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


It uses calico to implement the CNI for pod networking.

[ https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises ]

Using the following option to install Calico with Kubernetes API datastore, 50 nodes or less
This is 
```sh
$ curl https://docs.projectcalico.org/manifests/calico.yaml -O
$ kubectl apply -f calico.yaml
```



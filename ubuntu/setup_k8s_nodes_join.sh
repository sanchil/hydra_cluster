#!/bin/sh

sudo \
kubeadm join 192.168.58.100:6443 --token 2zzsp2.hwciuoas1ef9mp2z --discovery-token-ca-cert-hash sha256:28f1fbb7b22c827559b0943b370de6aae81b40fbe7ab89317860163e58a0ab0f 

Prerequisites

Ubuntu 22.04 LTS
Familiarity with Linux, CLI, and Kubernetes concepts
sudo privileges on your machines

## security groups 

master sg

![image](https://github.com/user-attachments/assets/99aaa119-8a4f-4d73-a4cb-5ecb1811c082)

![image](https://github.com/user-attachments/assets/86a4fe83-576c-4d7b-9603-f9c0a9167a67)


worker sg

![image](https://github.com/user-attachments/assets/916d1983-f21f-4dde-921c-a17e77e3c982)


![image](https://github.com/user-attachments/assets/3c950b84-7331-41d4-ab02-7a5a3b8d2c8e)



Setting up the Master Node

First, we’ll set up the master node, which will manage the cluster.

Step 1 : Update and Upgrade Ubuntu

Begin by updating your package lists and upgrading the existing packages to their latest versions.
```
sudo apt-get update
sudo apt-get upgrade
```
Step 2 : Disable Swap
```
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
Step 3 : Add Kernel Parameters
```
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
```
Reload the change

`sudo sysctl --system`
Step 4 : Install Containerd Runtime

```
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io
`
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl restart containerd
sudo systemctl enable containerd
```
Step 5 : Install Kubernetes Components:

Add the Kubernetes signing key and repository.
```
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

Step 6 : Update the package list and install kubelet, kubeadm, and kubectl.
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
Step 7 : Initialize Kubernetes Master Node: Initialize the Kubernetes cluster using kubeadm.

sudo kubeadm init

[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:
```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Alternatively, if you are the root user, you can run:

 ` export KUBECONFIG=/etc/kubernetes/admin.conf`

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:
```
kubeadm join 10.10.10.1:6443 --token qyq7z7.5augt56vin856fj \
 --discovery-token-ca-cert-hash sha256:09a1fc88c9fc8cab5171333546456455dd54cf3d8cb3400362586185308c3
 ```
To start using your cluster, set up the kubeconfig.
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Step 8 : Deploy a Pod Network: Install a pod network so that your nodes can communicate with each other.

`kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml`
Setting up the Worker Nodes
Now, configure your worker nodes.

Proceed above step 1– 6 on the worker nodes
Join the Worker Nodes:
On each worker node, use the join command you got from the master node’s init output.

`kubeadm join 10.10.10.1:6443 --token qyq7z7.5augt56vin856fj \
 --discovery-token-ca-cert-hash sha256:09a1fc88c9fc8cab5171333546456455dd54cf3d8cb3400362586185308c3`
 
Verifying the Cluster Setup
Ensure your cluster is up and running.

`kubectl get nodes`

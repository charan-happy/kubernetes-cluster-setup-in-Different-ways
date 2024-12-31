
## pre-requisites
- AWS account
- ACCESSKEY and SECRET KEY files

1. install AWS CLI tool
2. Install kubectl binaries

```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

```
3. EKS settings

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin
eksctl version
```
4. EKS cluster provisioning
`eksctl create cluster --name aws-eks-demo --version 1.30 --region ap-south-1 --nodegroup-name eks-demo-workers --node-type t3.micro --nodes 3 --nodes-min 1 --nodes-max 4 --managed`
5. update kubectl configuration
   `aws eks update-kubeconfig --name aws-eks-demo --region ap-south-1`
   

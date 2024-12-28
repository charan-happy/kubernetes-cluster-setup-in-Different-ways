# kubernetes-multinodesetup-terraform-aws-ansible
A Repository for multinode kubernetes cluster setup using aws, terraform and ansible using kubeadm - 1.28 Version
# Kubernetes v1.28 on AWS using Kubeadm and Terraform

## Installing tools

### Installing Terraform
```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```
### Installing Ansible
```
pip3 install ansible
```
```
$ sudo su
# whereis ansible
ansible: /usr/local/bin/ansible
```
Updating path
```
echo "export PATH=$PATH:/usr/local/bin/" >> ~/.bashrc
source ~/.bashrc
```
```
# ansible --version
# ansible-playbook --version
```
### Installing Git
```
yum install git -y
```

## Configure AWS CLI
### Create IAM user and add credentials
```
aws configure
```


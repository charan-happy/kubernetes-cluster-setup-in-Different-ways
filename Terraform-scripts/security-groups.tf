resource "aws_security_group" "k8s_master" {
  name        = "k8s_master_sg"
  description = "k8s_master security group"
  ingress {
    description = "SSH"
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
   ingress {
    description = "API Server"
    protocol  = "tcp"
    from_port = 6443
    to_port   = 6443
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "ETCD"
    protocol  = "tcp"
    from_port = 2379
    to_port   = 2380
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Weavenet TCP"
    protocol  = "tcp"
    from_port = 6783
    to_port   = 6783
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Weavenet UDP"
    protocol  = "udp"
    from_port = 6784
    to_port   = 6784
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "kubelet API, kube-scheduler, kube-controller-manager, read-only kubelet api, kubelet health"
    protocol  = "tcp"
    from_port = 10248
    to_port   = 10260
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Nodeport Services"
    protocol  = "tcp"
    from_port = 30000
    to_port   = 32767
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s_master_sg"
  }
}

resource "aws_security_group" "k8s_worker" {
  name        = "k8s_worker_sg"
  description = "k8s_worker security group"
  ingress {
    description = "SSH"
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Weavenet TCP"
    protocol  = "tcp"
    from_port = 6783
    to_port   = 6783
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Weavenet UDP"
    protocol  = "udp"
    from_port = 6784
    to_port   = 6784
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "kubelet API, kube-scheduler, kube-controller-manager, read-only kubelet api, kubelet health"
    protocol  = "tcp"
    from_port = 10248
    to_port   = 10260
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Nodeport Services"
    protocol  = "tcp"
    from_port = 30000
    to_port   = 32767
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s_worker_sg"
  }
}



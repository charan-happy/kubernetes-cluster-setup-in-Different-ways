resource "aws_key_pair" "k8s" {
  key_name   = "k8s"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
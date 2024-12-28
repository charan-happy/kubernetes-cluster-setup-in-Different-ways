output "master" {
    value = aws_instance.k8s_master.public_ip
}

output "workers" {
  value = aws_instance.k8s_worker[*].public_ip
}


output "private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_instance" "k8s_master" {
  ami = var.ami.master
  instance_type = var.instance_type.master
  security_groups = ["k8s_master_sg"]
 connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.ssh_key.private_key_pem
    host     = self.public_ip
  }
  provisioner "file" {
    source      = "~/master.sh"
    destination = "/home/ubuntu/master.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/master.sh",
      "sudo sh /home/ubuntu/master.sh k8s-master"
    ]
  }
  tags = {
    Name = "k8s-master"
  }
}

# launch worker nodes
resource "aws_instance" "k8s_worker" {
  count = var.worker_instance_count
  ami = var.ami.worker
  instance_type = var.instance_type.worker
  key_name = aws_key_pair.k8s.key_name
  security_groups = ["k8s_worker_sg"]
  depends_on = [ aws_instance.k8s_master ]
 connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.ssh_key.private_key_pem
    host     = self.public_ip
  }
  provisioner "file" {
    source      = "~/worker.sh"
    destination = "/home/ubuntu/master.sh"
  }
  provisioner "file" {
    source = "./join-command.sh"
    destination = "/home/ubuntu/join-command.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/worker.sh",
      "sudo sh /home/ubuntu/worker.sh k8s-worker-${count.index}",
      "sudo sh /home/ubuntu/join-command.sh"
    ]
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' playbook.yml"
  }
  tags = {
    Name = "k8s-worker-${count.index}"
  }
}


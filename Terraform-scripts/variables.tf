variable "region" {
  default = "ap-south-1"
}
variable "ami" {
  type = map(string)
  default = {
    "master" = "ami-09b0a86a2c84101e1"
    "worker" = "ami-09b0a86a2c84101e1"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    "master" = "t2.medium"
    "worker" = "t2.micro"
  }
}

variable "worker_instance_count" {
  type = number
  default = 2
}
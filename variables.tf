//EC2 Variables

variable "ami_id" {
  type = string
  description = "AMI ID"
  default = "ami-02a2af70a66af6dfb"
}

variable "instance_type" {
  type = string
  description = "Instance Type"
  default = "t2.micro"
}

variable "key_name" {
  type = string
  description = "Key Name"
  default = "Devkops"
}

variable "tags" {
  type = map(string)
  description = "common tags"
  default = {
    "Env" = "Dev"
  }
}


//VPC Variables

variable "vpc_cidr" {
  type = string
  description = "VPC CIDR Block"
  default = "172.35.0.0/16"
}

variable "dns_hostnames" {
  type = bool
  description = "Enable/Disable DNS HOSTNAME VPC"
  default = true
}

variable "azones" {
  type = list(string)
  description = "Availability Zones"
  default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "tf-public-subnets" {
  type = list(string)
  description = "Public Subnets"
  default = [ "172.35.0.0/18", "172.35.64.0/18" ]
}

variable "tf-private-subnets" {
  type = list(string)
  description = "Private Subnets"
  default = [ "172.35.128.0/18", "172.35.192.0/18" ]
}
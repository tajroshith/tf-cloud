//EC2 Variables

variable "ami_id" {
  type = string
  description = "AMI ID"
}

variable "instance_type" {
  type = string
  description = "Instance Type"
}

variable "key_name" {
  type = string
  description = "Key Name"
}

variable "tags" {
  type = map(string)
  description = "common tags"
}


//VPC Variables

variable "vpc_cidr" {
  type = string
  description = "VPC CIDR Block"
}

variable "dns_hostnames" {
  type = bool
  description = "Enable/Disable DNS HOSTNAME VPC"
}

variable "azones" {
  type = list(string)
  description = "Availability Zones"
}

variable "tf-public-subnets" {
  type = list(string)
  description = "Public Subnets"
}

variable "tf-private-subnets" {
  type = list(string)
  description = "Private Subnets"
}
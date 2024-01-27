ami_id = "ami-02a2af70a66af6dfb"
instance_type = "t2.micro"
key_name = "Devkops"
tags = {
  "Env" = "Dev"
}

vpc_cidr = "172.35.0.0/16"
dns_hostnames = true
azones = [ "ap-south-1a", "ap-south-1b" ]
tf-public-subnets = [ "172.35.0.0/18", "172.35.64.0/18" ]
tf-private-subnets = [ "172.35.128.0/18", "172.35.192.0/18" ]
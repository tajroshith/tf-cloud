resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.dns_hostnames
  tags = merge(var.tags, {
    "Name" = "tf_vpc"
  }
 )
}

resource "aws_subnet" "tf-public-subnets" {
  count = length(var.tf-public-subnets)
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = element(var.tf-public-subnets, count.index)
  availability_zone = element(var.azones, count.index)
  tags = merge(var.tags, {
    "Name" = "tf-public-subnets-${count.index + 1}"
  }
 )
}

resource "aws_subnet" "tf-private-subnets" {
  count = length(var.tf-private-subnets)
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = element(var.tf-private-subnets, count.index)
  availability_zone = element(var.azones, count.index)
  tags = merge(var.tags, {
    "Name" = "tf-private-subnets-${count.index + 1}"
  }
 )
}

resource "aws_eip" "tf-eip" {
  domain = "vpc"
  tags = merge(var.tags, {
    "Name" = "tf-eip"
  }
 )
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = merge(var.tags, {
    "Name" = "tf-igw"
  }
 )
}

resource "aws_route_table" "tf-rtb-public" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
  tags = merge(var.tags, {
    "Name" = "tf-rtb-public"
  }
 )
}

resource "aws_route_table_association" "tf-rtb-public-assoc" {
    count = length(var.tf-public-subnets)
    subnet_id = element(aws_subnet.tf-public-subnets[*].id, count.index)
    route_table_id = aws_route_table.tf-rtb-public.id
}

resource "aws_nat_gateway" "tf-ngw" {
  allocation_id = aws_eip.tf-eip.id
  subnet_id = aws_subnet.tf-public-subnets[0].id
  tags = merge(var.tags, {
    "Name" = "tf-ngw"
  }
 )
 depends_on = [ aws_internet_gateway.tf-igw ]
}

resource "aws_route_table" "tf-rtb-private" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-ngw.id
  }
  tags = merge(var.tags, {
    "Name" = "tf-rtb-priv"
  }
 )
}

resource "aws_route_table_association" "tf-rtb-private-assoc" {
  count = length(var.tf-private-subnets)
  subnet_id = element(aws_subnet.tf-private-subnets[*].id, count.index)
  route_table_id = aws_route_table.tf-rtb-private.id
}

/*
Resources Used
- VPC -- tf-vpc(172.35.0.0/16)
- Internet Gateway - tf-igw
- Subnets - 
- 172.35.0.0/18,172.35.64.0/18 --- Public
- 172.35.128.0/18,172.35.192.0/18 --- Private
- Route Tables - 2 (tf-rtb-public,tf-rtb-private)
- Route Table Association - 2 (tf-rtb-public-assoc, tf-rtb-private-assoc)
- Elastic IP - 1 - tf_eip
- 1 Nat Gateway on Public Subnet - tf-ngw
*/

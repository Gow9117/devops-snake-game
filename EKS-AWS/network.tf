############################
# VPC
############################
resource "aws_vpc" "gowtham_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "gowtham_vpc"
  }
}

############################
# Subnets (2 public subnets)
############################
resource "aws_subnet" "gowtham_subnet" {
  count = 2

  vpc_id     = aws_vpc.gowtham_vpc.id
  cidr_block = cidrsubnet(aws_vpc.gowtham_vpc.cidr_block, 8, count.index)

  availability_zone       = element(["ap-northeast-1a", "ap-northeast-1c"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "gowtham_subnet-${count.index}"
  }
}

############################
# Internet Gateway
############################
resource "aws_internet_gateway" "gowtham_igw" {
  vpc_id = aws_vpc.gowtham_vpc.id

  tags = {
    Name = "gowtham_igw"
  }
}

############################
# Route Table
############################
resource "aws_route_table" "gowtham_rt" {
  vpc_id = aws_vpc.gowtham_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gowtham_igw.id
  }

  tags = {
    Name = "gowtham_route_table"
  }
}

############################
# Route Table Association
############################
resource "aws_route_table_association" "gowtham_rt_assoc" {
  count = 2

  subnet_id      = aws_subnet.gowtham_subnet[count.index].id
  route_table_id = aws_route_table.gowtham_rt.id
}

############################
# Security Groups
############################

# EKS Cluster Security Group
resource "aws_security_group" "gowtham_cluster_sg" {
  vpc_id = aws_vpc.gowtham_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gowtham-cluster-sg"
  }
}

# Worker Node Security Group
resource "aws_security_group" "gowtham_node_sg" {
  vpc_id = aws_vpc.gowtham_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gowtham-node-sg"
  }
}
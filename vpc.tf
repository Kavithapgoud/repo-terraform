resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

   tags = {
    Name = "vpc-tf"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.public_subnet_az

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.private_subnet_az

  tags = {
    Name = "private-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw_main"
  }
}
resource "aws_eip" "EIP" {
  tags = {
    Name = "Nat-EIP"
  }
}
resource "aws_nat_gateway" "NAT-tf" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.subnet_a.id

  tags = {
    Name = "Nat-gateway"
  }
}
resource "aws_route_table" "public"{
vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_rt
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
      Name = "RT-public"
  }
}

resource "aws_route_table" "private"{
vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_rt
    gateway_id = aws_nat_gateway.NAT-tf.id
  }
    tags = {
    Name = "RT-Private"
  }
}
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.private.id
}



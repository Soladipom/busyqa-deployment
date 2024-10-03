resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.public_subnet_cidr, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.private_subnet_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

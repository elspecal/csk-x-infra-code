locals {
  region = "eu-west-3"
  subnets = {
    a = "10.0.1.0/24"
    b = "10.0.2.0/24"
  }
}
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  region     = local.region
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true

  for_each          = local.subnets
  availability_zone = "${local.region}${each.key}"
  cidr_block        = each.value
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  route {
    gateway_id = aws_internet_gateway.this.id
    cidr_block = "0.0.0.0/0"
  }

  route {
    gateway_id = "local"
    cidr_block = aws_vpc.this.cidr_block
  }
}

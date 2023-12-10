# Internet Gateway
resource "aws_internet_gateway" "hanghae_internet_gateway" {
  vpc_id = aws_vpc.hanghae_vpc.id
}

resource "aws_route" "hanghae_internet_access_route" {
  route_table_id          = aws_vpc.hanghae_vpc.main_route_table_id
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = aws_internet_gateway.hanghae_internet_gateway.id
  depends_on                = [aws_route_table.hanghae_internet_gateway_route_table]
}

resource "aws_route_table" "hanghae_internet_gateway_route_table" {
  vpc_id = aws_vpc.hanghae_vpc.id


  tags = {
    Name = "route_for_internet_gateway"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hanghae_internet_gateway.id
  }
}

resource "aws_route_table_association" "hanghae_prod_public_subnet_route_association" {
  subnet_id      = aws_subnet.hanghae_prod_public_subnet.id
  route_table_id = aws_route_table.hanghae_internet_gateway_route_table.id
}

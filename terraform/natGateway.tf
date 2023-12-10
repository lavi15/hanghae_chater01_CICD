# Nat Gateway
resource "aws_eip" "hanghae_prod_nat_gateway_ip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "hanghae_prod_nat_gateway" {
  allocation_id = aws_eip.hanghae_prod_nat_gateway_ip.id
  subnet_id     = aws_subnet.hanghae_prod_public_subnet.id
}

resource "aws_route_table" "hanghae_prod_nat_gateway_route_table" {
  vpc_id = aws_vpc.hanghae_vpc.id

  tags = {
    Name = "route_for_nat_gateway"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.hanghae_prod_nat_gateway.id
  }
}

resource "aws_route_table_association" "hanghae_prod_subnet_route_table_association" {
  subnet_id      = aws_subnet.hanghae_prod_private_subnet.id
  route_table_id = aws_route_table.hanghae_prod_nat_gateway_route_table.id
}
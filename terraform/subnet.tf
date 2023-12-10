#Public Subnet
resource "aws_subnet" "hanghae_prod_public_subnet" {
  vpc_id            = aws_vpc.hanghae_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "hanghae_prod_private_subnet" {
  vpc_id            = aws_vpc.hanghae_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
}

resource "aws_subnet" "hanghae_prod_private_subnet_2b" {
  vpc_id            = aws_vpc.hanghae_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-2b"
}
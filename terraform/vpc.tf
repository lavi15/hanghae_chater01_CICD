#VPC
resource "aws_vpc" "hanghae_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "hanghae_vpc"
  }
}


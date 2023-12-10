# Security Group
resource "aws_security_group" "hanghae_was_sg" {
  vpc_id = aws_vpc.hanghae_vpc.id
  name   = "hanghae-was-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

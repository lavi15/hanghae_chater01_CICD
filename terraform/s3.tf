#s3
resource "aws_s3_bucket" "hanghae_s3_prod" {
  bucket = var.s3.prod

  tags = {
    Name        = var.s3.prod
    Environment = "prod"
  }
}

#LB
resource "aws_lb" "hanghae_prod_lb" {
  name               = "hanghae-prod-lb"
  subnets            = [aws_subnet.hanghae_prod_private_subnet.id, aws_subnet.hanghae_prod_private_subnet_2b.id]
  load_balancer_type = "application"
  security_groups    = [aws_security_group.hanghae_was_sg.id]

  tags = {
    Environment = "prod"
  }
}

resource "aws_lb_listener" "hanghae_prod_lb_listener" {
  load_balancer_arn = aws_lb.hanghae_prod_lb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hanghae_prod_lb_target_group.arn
  }
}


resource "aws_lb_target_group" "hanghae_prod_lb_target_group" {
  name        = "hanghae-prod-lb-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.hanghae_vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/actuator"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}

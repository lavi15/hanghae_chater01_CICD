#ECS Cluster
resource "aws_ecs_cluster" "hanghae_prod_fargate_cluster" {
  name = "hanghae-prod-fargate-cluster"
}

#ECS Task
resource "aws_ecs_task_definition" "hanghae_prod_was" {
  family                   = var.aws_ecs_task_definition.prod_family
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.hanghae_ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.hanghae_ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name      = "was"
      image     = var.ecs_task.was_image
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.hanghae_ecs_log_group.name
          awslogs-region        = "ap-northeast-2"
          awslogs-stream-prefix = "ecs"
        }
      }
    }])
  tags = {
    Environment = "prod"
    Application = "was"
  }
}

#ECS Service
resource "aws_ecs_service" "hanghae_prod_was" {
  name                               = "hanghae-prod-was"
  cluster                            = aws_ecs_cluster.hanghae_prod_fargate_cluster.id
  task_definition                    = aws_ecs_task_definition.hanghae_prod_was.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.hanghae_was_sg.id]
    subnets          = [aws_subnet.hanghae_prod_public_subnet.id, aws_subnet.hanghae_prod_private_subnet.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hanghae_prod_lb_target_group.arn
    container_name   = "was"
    container_port   = "8080"
  }
}


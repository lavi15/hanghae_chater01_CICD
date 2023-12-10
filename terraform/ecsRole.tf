#ECR Task Execution Role
resource "aws_iam_role" "hanghae_ecs_task_execution_role" {
  name = "hanghae-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
      }
    ]
  })
}

resource "aws_iam_role_policy" "hanghae_ecs_task_execution_policy_add" {
  name = "hanghae-ecs-task-execution-policy-add"
  role = aws_iam_role.hanghae_ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:*",
          "ecr:*",
          "logs:*",
          "cloudwatch:*",
          "elasticloadbalancing:*"
        ],
        Resource = "*"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "hanghae_ecs_task_execution_role-policy_attachment" {
  role       = aws_iam_role.hanghae_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ECS Task Role
resource "aws_iam_role" "hanghae_ecs_task_role" {
  name = "hanghae-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
      }
    ]
  })
}

resource "aws_iam_role_policy" "hanghae_ecs_task_policy_add" {
  name = "hanghae-ecs-task-policy-add"
  role = aws_iam_role.hanghae_ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecs:*",
          "ecr:*",
          "logs:*",
          "cloudwatch:*",
          "elasticloadbalancing:*"
        ],
        Resource = "*"
      }
    ]
  })
}

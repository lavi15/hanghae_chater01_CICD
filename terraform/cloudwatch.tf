#Cloudwatch
data "aws_iam_policy_document" "ecs_logging_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [aws_cloudwatch_log_group.hanghae_ecs_log_group.arn]
  }
}

resource "aws_iam_policy" "hanghae_ecs_logging_policy" {
  name   = "hanghae_ecs_logging_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_logging_policy.json
}

resource "aws_cloudwatch_log_group" "hanghae_ecs_log_group" {
  name = "/hanghae/logs"
}

resource "aws_iam_role_policy_attachment" "hanghae_ecs_logging_policy_attachment" {
  role       = aws_iam_role.hanghae_ecs_task_execution_role.name
  policy_arn = aws_iam_policy.hanghae_ecs_logging_policy.arn
}


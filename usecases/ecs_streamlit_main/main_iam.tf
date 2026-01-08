resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.stage}-ecs-streamlit-execution-role-${var.iactool}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json
}

resource "aws_iam_role_policy_attachments_exclusive" "ecs_task_execution_managed_policy" {
  policy_arns = [data.aws_iam_policy.managed_ecs_task_execution.arn]
  role_name = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role_policy" "ecs_task_execution_inline_policy" {
  name = "${var.stage}-ecs-streamlit-task-execution-policy-${var.iactool}"
  policy = data.aws_iam_policy_document.ecs_task_execution.json
  role = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role" "ecs_task" {
  name = "${var.stage}-ecs-streamlit-task-role-${var.iactool}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

resource "aws_iam_role_policy" "ecs_task_inline_policy" {
  name = "${var.stage}-ecs-streamlit-task-policy-${var.iactool}"
  policy = data.aws_iam_policy_document.ecs_task.json
  role = aws_iam_role.ecs_task.name
}
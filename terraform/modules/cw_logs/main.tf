resource "aws_cloudwatch_log_group" "codebuild" {
  name = "/codebuild/${var.app_name}"
}
resource "aws_cloudwatch_event_rule" "pipeline_ecr_rule" {
  name          = "${var.app_name}-pipeline-ecr-rule"

  # ECR pushされた時、CodePipelineに知らせる必要がある
  # https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/action-reference-ECR.html
  event_pattern = templatefile("./modules/cw_events/event_pattern.tpl", {
    repository_name = var.repository_name
  })
}

resource "aws_cloudwatch_event_target" "target_codepipeline" {
  rule      = aws_cloudwatch_event_rule.pipeline_ecr_rule.name
  target_id = "${var.app_name}-target-codepipeline"
  arn       = var.pipeline_arn
  role_arn  = var.cw_events_iam_role_arn
}
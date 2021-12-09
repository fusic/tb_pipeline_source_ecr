data "aws_iam_policy_document" "assumerole" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cw_event_ecr_role" {
  name               = "${var.app_name}-cw-event-ecr"
  assume_role_policy = data.aws_iam_policy_document.assumerole.json
}

resource "aws_iam_policy" "cw_event_ecr_policy" {
  name        = "${var.app_name}-cw-event-ecr"
  description = "ECR pushされた時codepipelineをstartできるようにする"
  
  policy      = templatefile("./modules/iam/codepipeline/cw_events/policy.tpl", {
    pipeline_arn = var.pipeline_arn
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline" {
  role       = aws_iam_role.cw_event_ecr_role.id
  policy_arn = aws_iam_policy.cw_event_ecr_policy.arn
}
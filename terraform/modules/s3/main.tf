resource "aws_s3_bucket" "pipeline_artifact" {
  bucket        = "${var.app_name}-pipeline-artifact"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket" "codebuild_buildspec" {
  bucket        = "${var.app_name}-codebuild-buildspec"
  acl           = "private"
  force_destroy = true

  # codepipelineの正確な参照のために必要
  versioning {
    enabled = true
  }
}
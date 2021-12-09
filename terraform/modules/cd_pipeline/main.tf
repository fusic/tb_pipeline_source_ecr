resource "aws_codepipeline" "main" {
  name     = var.app_name
  role_arn = var.iam_role_codepipeline_arn

  artifact_store {
    type     = "S3"
    location = var.s3_pipeline_artifact_id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "ECR"
      version          = "1"
      run_order        = 1
      output_artifacts = ["ecr_source"]

      configuration = {
        RepositoryName = var.ecr_web_name
        ImageTag       = var.app_env # stgとかprdとか
      }
    }

    # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-S3.html
    action {
      category         = "Source"
      configuration    = {
        "PollForSourceChanges" = "false"
        "S3Bucket"             = var.buildspec_bucket_name
        "S3ObjectKey"          = "build.zip"
      }
      name             = "s3_source"
      output_artifacts = ["s3_source"]
      owner            = "AWS"
      provider         = "S3"
      run_order        = 1
      version          = "1"
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 2
      input_artifacts  = ["s3_source"]
      configuration    = {
        ProjectName = var.app_name
      }
    }
  }
}
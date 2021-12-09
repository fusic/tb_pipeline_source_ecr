output pipeline_artifact {
  value = aws_s3_bucket.pipeline_artifact
}

output codebuild_buildspec {
  value = aws_s3_bucket.codebuild_buildspec
}
###########################################
# codepipeline
###########################################
module codepipeline {
  source                    = "./modules/cd_pipeline"

  app_name                  = var.app_name
  app_env                   = var.app_env
  iam_role_codepipeline_arn = module.iam_codepipeline.role.arn
  s3_pipeline_artifact_id   = module.s3.pipeline_artifact.id

  ecr_web_name              = module.ecr.web.name
  buildspec_bucket_name     = module.s3.codebuild_buildspec.bucket
}

module iam_codepipeline {
  source                    = "./modules/iam/codepipeline"

  app_name                  = var.app_name
  s3_pipeline_artifact_id   = module.s3.pipeline_artifact.id
  s3_codebuild_buildspec_id = module.s3.codebuild_buildspec.id
}

module cw_events_pipeline_rule {
  source                 = "./modules/cw_events"

  app_name               = var.app_name
  repository_name        = module.ecr.web.name
  pipeline_arn           = module.codepipeline.main.arn
  cw_events_iam_role_arn = module.cw_events_iam_role.role.arn
}

module cw_events_iam_role {
  source       = "./modules/iam/codepipeline/cw_events"

  app_name     = var.app_name
  pipeline_arn = module.codepipeline.main.arn
}

###########################################
# codebuild
###########################################
module codebuild {
  source                 = "./modules/cdb"

  app_name               = var.app_name
  iam_role_codebuild_arn = module.iam_codebuild.role.arn
  cw_logs_codebuild_name = module.cw_logs.codebuild.name
}

module iam_codebuild {
  source                   = "./modules/iam/codebuild"

  app_name                 = var.app_name
  ecr_web_repository_arn   = module.ecr.web.arn
  s3_pipeline_artifact_arn = module.s3.pipeline_artifact.arn
}

###########################################
# 共通
###########################################
module s3 {
  source   = "./modules/s3"

  app_name = var.app_name
}

# module.ecr.web
module ecr {
  source   = "./modules/ecr"

  app_name = var.app_name
}

# module.cw_logs.codebuild
module cw_logs {
  source   = "./modules/cw_logs"

  app_name = var.app_name
}
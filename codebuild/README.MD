### codepipelineとcodebuildのためにS3にzipをアップロード
- codebuildが `何をすればいい` を定義するbuildspec.ymlをアップロードすることが目的です
- codebuildが認識できるのはzipだけですからzipにしてS3にアップロードします
- S3 `$AWS_SP_APP_NAME-codebuild-buildspec` はterraformで作成します

```
export AWS_SP_PROFILE_NAME=src-ecr-prd
export AWS_SP_ACCOUNT_ID=xxxxx
export AWS_SP_APP_NAME=src-ecr-prd
export AWS_SP_APP_ENV=prd

cd APP_ROOT/codebuild
sh ./update_codebuild_files.sh
```
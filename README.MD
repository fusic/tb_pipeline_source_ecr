# TerraformでAWS CodePipeline(ECR pushで発火) + CodeBuildを作る

## APP_ROOTにcdで移動する
```
cd APP_ROOT
```

## exportでshellで使う環境変数を設定する
AWSコンソール上でアカウントIDを確認してから下の `AWS_SP_ACCOUNT_ID` に設定してください。

```
export AWS_SP_PROFILE_NAME=src-ecr-prd
export AWS_SP_ACCOUNT_ID=xxxxx
export AWS_SP_APP_NAME=src-ecr-prd
export AWS_SP_APP_ENV=prd
```

## Codebuild用buildspecとCodedeploy用ファイルをzipでアップロード
```
cd APP_ROOT/codebuild
sh update_codebuild_files.sh
```

## ECRへdocker imageたちをbuildしてpushする
```
cd APP_ROOT
sh deploy_by_pushing_docker.sh
```
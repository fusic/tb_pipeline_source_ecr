#!/bin/bash

ECR_REPO=$AWS_SP_ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com

# ECRログイン
aws ecr get-login-password \
  --region ap-northeast-1 \
  --profile $AWS_SP_PROFILE_NAME \
| docker login \
  --username AWS \
  --password-stdin $ECR_REPO

#### ruby(web) docker image
WEB_CONTAINER_NAME=src-ecr
ECR_WEB_URI=$ECR_REPO/$AWS_SP_APP_NAME:$AWS_SP_APP_ENV

docker build -t $ECR_WEB_URI . -f ./docker/production/Dockerfile
docker push $ECR_WEB_URI
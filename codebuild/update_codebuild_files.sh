#!/bin/bash

zip -r9 build.zip .

aws s3 cp ./build.zip s3://$AWS_SP_APP_NAME-codebuild-buildspec/build.zip --profile $AWS_SP_PROFILE_NAME
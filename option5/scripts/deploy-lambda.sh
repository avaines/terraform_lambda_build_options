#!/bin/bash
set -euo pipefail

# Quick script to deploy a function
#  ./deploy-lambda.sh s3_bucket s3_object lambda_function_name

aws lambda update-function-code \
  --s3-bucket "${1}" \
  --s3-key "${2}" \
  --function-name "${3}" \
  --publish

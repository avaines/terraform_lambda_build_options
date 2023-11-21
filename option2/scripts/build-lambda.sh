#!/bin/bash
set -euo pipefail

# Quick script to deploy a functions code to S3
#  ./build-lambda.sh test_func my-s3-bucket

pushd ../../src/

zip -9rX "${1}.zip" .

aws s3 cp "${1}".zip s3://"${2}"/ \
  --metadata Commit="$(git rev-parse HEAD)",Function="${1}",Hash="$(openssl dgst -binary -sha256 "${1}".zip | openssl base64)"

popd

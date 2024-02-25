#!/bin/bash
# Quick script to deploy a functions code to S3
#  ./build-lambda.sh test_func my-s3-bucket
set -euo pipefail

pushd "../../src/${1}"

zip -9rX "../${1}.zip" .

aws s3 cp "../${1}".zip s3://"${2}"/ \
  --metadata Commit="$(git rev-parse HEAD)",Function="${1}",Hash="$(openssl dgst -binary -sha256 "../${1}".zip | openssl base64)"

popd

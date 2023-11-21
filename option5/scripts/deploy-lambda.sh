#!/bin/bash
set -euo pipefail

# Quick script to deploy a function
#  ./build-lambda.sh test_func option5-lambda

pushd "../../src/${1}"

zip -9rX "../${1}.zip" .

aws lambda update-function-code \
  --function-name "${2}" \
  --zip-file "fileb://../${1}.zip"

popd

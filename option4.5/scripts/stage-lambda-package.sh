#!/bin/bash
# Quick script to deploy a functions code to S3
#  ./stage-lambda-package.sh test_func my-s3-bucket
set -euo pipefail

TARGET_LAMBDA="${1}"

# Set working DIR for script execution duration
cd "../../src/"

STAGING_DIR="./staging/staged_${TARGET_LAMBDA}"

# Do some tidying
if [ -d "${STAGING_DIR}" ]; then
    rm -Rf "./${STAGING_DIR}"
    mkdir -p "${STAGING_DIR}"
else
    mkdir -p "${STAGING_DIR}"
fi

# Copy the target lambda
rsync -av \
    --exclude "*/__pycache__" \
    "${TARGET_LAMBDA}" "${STAGING_DIR}" > /dev/null 2>&1

# Copy the common code library
rsync -av \
    --exclude "*/__pycache__" \
   test_common "${STAGING_DIR}" > /dev/null 2>&1

jq -ncM \
  '{ "lambda_staging_dir": $a }' \
  --arg a "${STAGING_DIR}"

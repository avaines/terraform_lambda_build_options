#!/bin/bash

BUCKET_NAME="${1}"
OBJECT_KEY="${2}"

echo "VersionID                         SHA256 Hash"
echo "--------------------------------  --------------------------------------------------"

for version_id in $(aws s3api list-object-versions --bucket "${BUCKET_NAME}" --prefix "${OBJECT_KEY}" --output json | jq -r '.Versions[]|.VersionId'); do
    if [ $version_id == "null" ]; then
        version_sha=$(aws s3api head-object --bucket "${BUCKET_NAME}" --key "${OBJECT_KEY}" | jq -r '.Metadata.hash')
        version_id="Latest                          "
    else
        version_sha=$(aws s3api head-object --bucket "${BUCKET_NAME}" --key "${OBJECT_KEY}" --version-id ${version_id} | jq -r '.Metadata.hash')
    fi    
    echo "${version_id} | ${version_sha}"
done

#!/bin/bash
# Build Contrast image
IMAGE_NAME=contrast/java-agent
CONTRAST_AGENT_VERSION=3.8.7.21531
BUILD_DATE=$(date)
echo $BUILD_DATE
COMMIT_HASH=$(git rev-parse --verify HEAD)
echo $COMMIT_HASH
docker build . --no-cache \
--build-arg CONTRAST_AGENT_VERSION="$CONTRAST_AGENT_VERSION" \
--build-arg BUILD_DATE="$BUILD_DATE" \
--build-arg COMMIT_HASH="$COMMIT_HASH" \
-f Dockerfile-Contrast \
--tag "$IMAGE_NAME:$CONTRAST_AGENT_VERSION"

# Build application image
IMAGE_NAME=contrast/webgoat
WEBGOAT_VERSION=8.1.0
docker build . --no-cache \
--build-arg WEBGOAT_VERSION=${WEBGOAT_VERSION} \
-f Dockerfile-App \
--tag ${IMAGE_NAME}:${WEBGOAT_VERSION}

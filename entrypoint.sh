#!/bin/sh
set -o errexit
set -o nounset

export PLANTON_CLOUD_CLI_ENVIRONMENT=${1}
export PLANTON_CLOUD_CLIENT_ID=${2}
export PLANTON_CLOUD_CLIENT_SECRET=${3}
export PLANTON_CLOUD_ENVIRONMENT_ID=${4}
export PLANTON_CLOUD_ENVIRONMENT_NAME=${5}
export MICROSERVICE_INSTANCE_VERSION=${6}
export CONTAINER_IMAGE_TAG=${7}

if ! [ -n "${PLANTON_CLOUD_CLIENT_ID}" ]; then
  echo "PLANTON_CLOUD_CLIENT_ID is not set. Configure Machine Account Credentials for Repository or Organization."
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_CLIENT_SECRET}" ]; then
  echo "PLANTON_CLOUD_CLIENT_SECRET is not set. Configure Machine Account Credentials for Repository or Organization."
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_ENVIRONMENT_ID}" ]; then
  echo "PLANTON_CLOUD_ENVIRONMENT_ID is required. It should be set to the id of the target environment on planton cloud"
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_ENVIRONMENT_NAME}" ]; then
  echo "PLANTON_CLOUD_ENVIRONMENT_NAME is required. It should be set to the id of the target environment on planton cloud"
  exit 1
fi
if ! [ -n "${MICROSERVICE_INSTANCE_VERSION}" ]; then
  echo "MICROSERVICE_INSTANCE_VERSION is required. It should be set to main or review-<pull-request-number>"
  exit 1
fi
if ! [ -n "${CONTAINER_IMAGE_TAG}" ]; then
  echo "CONTAINER_IMAGE_TAG is required. It should be set to value of the container image tag"
  exit 1
fi

echo "running deployment for microservice-instance version: $MICROSERVICE_INSTANCE_VERSION"
echo "exchanging planton-cloud client credentials to get an access token"
planton auth machine login \
  --client-id $PLANTON_CLOUD_CLIENT_ID \
  --client-secret $PLANTON_CLOUD_CLIENT_SECRET
echo "successfully exchanged planton-cloud client credentials and received an access token"
echo "upserting microservice-instance on planton cloud"
planton microservice deploy  \
  --env-name $PLANTON_CLOUD_ENVIRONMENT_NAME \
  --version $PLANTON_CLOUD_MICROSERVICE_INSTANCE_VERSION \
  --container-image-tag $CONTAINER_IMAGE_TAG
echo "microservice instance has been successfully deployed"

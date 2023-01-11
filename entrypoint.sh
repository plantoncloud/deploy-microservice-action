#!/bin/sh
set -o errexit
set -o nounset

export PLANTON_CLOUD_SERVICE_CLI_ENV=${1}
export PLANTON_CLOUD_SERVICE_CLIENT_ID=${2}
export PLANTON_CLOUD_SERVICE_CLIENT_SECRET=${3}
export PLANTON_CLOUD_PRODUCT_ENV_ID=${4}
export PLANTON_CLOUD_MICROSERVICE_ID=${5}
export MICROSERVICE_DEPLOYMENT_VERSION=${6}
export CONTAINER_IMAGE_NAME=${7}
export CONTAINER_IMAGE_VERSION=${8}

if ! [ -n "${PLANTON_CLOUD_SERVICE_CLIENT_ID}" ]; then
  echo "PLANTON_CLOUD_SERVICE_CLIENT_ID is not set. Configure Machine Account Credentials for Repository or Organization."
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_SERVICE_CLIENT_SECRET}" ]; then
  echo "PLANTON_CLOUD_SERVICE_CLIENT_SECRET is not set. Configure Machine Account Credentials for Repository or Organization."
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_PRODUCT_ENV_ID}" ]; then
  echo "PLANTON_CLOUD_PRODUCT_ENV_ID is required. It should be set to the id of the target product environment on planton cloud"
  exit 1
fi
if ! [ -n "${PLANTON_CLOUD_MICROSERVICE_ID}" ]; then
  echo "PLANTON_CLOUD_MICROSERVICE_ID is required. It should be set to the id of the microservice on planton cloud"
  exit 1
fi
if ! [ -n "${MICROSERVICE_DEPLOYMENT_VERSION}" ]; then
  echo "MICROSERVICE_DEPLOYMENT_VERSION is required. It should be set to main or review-<pull-request-number>"
  exit 1
fi
if ! [ -n "${CONTAINER_IMAGE_NAME}" ]; then
  echo "CONTAINER_IMAGE_NAME is required. It should be set to the value of the container image name"
  exit 1
fi
if ! [ -n "${CONTAINER_IMAGE_VERSION}" ]; then
  echo "CONTAINER_IMAGE_VERSION is required. It should be set to value of the container image tag"
  exit 1
fi

echo "running deployment for microservice deployment version: $MICROSERVICE_DEPLOYMENT_VERSION"
echo "exchanging planton-cloud machine-account credentials to get an access token"
planton auth machine login \
  --client-id $PLANTON_CLOUD_SERVICE_CLIENT_ID \
  --client-secret $PLANTON_CLOUD_SERVICE_CLIENT_SECRET
echo "successfully exchanged planton-cloud machine-account credentials and received an access token"
echo "creating a new microservice deployment on planton cloud"
planton product microservice deployment create \
  --product-env-id $PLANTON_CLOUD_PRODUCT_ENV_ID \
  --microservice-id $PLANTON_CLOUD_MICROSERVICE_ID \
  --container-image $CONTAINER_IMAGE_NAME:$CONTAINER_IMAGE_VERSION \
  --microservice-version $MICROSERVICE_DEPLOYMENT_VERSION \
  --output-file deploy-$MICROSERVICE_DEPLOYMENT_VERSION.yaml
echo "created a new microservice deployment on planton cloud"
echo "waiting for microservice-deployment to sync on planton cloud"
sleep 20
echo "executing microservice deployment"
planton product microservice deployment deploy --input-file deploy-$MICROSERVICE_DEPLOYMENT_VERSION.yaml
echo "microservice deployment execution completed"

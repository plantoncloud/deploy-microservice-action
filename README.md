# GitHub Action: Deploy Microservice using Planton Cloud

This repository provides a GitHub Action to deploy a Microservice to an environment managed by Planton Cloud.

The action performs the following step:

**Deploy Microservice:** Uses Planton CLI to deploy a Microservice instance to a specified environment on Planton Cloud. The version of the Microservice instance and the tag of the Docker image are input parameters.

## Inputs

This action requires the following inputs:

- `planton_cloud_environment_name`: The name of the target environment on Planton Cloud. This is a required input.

- `planton_cloud_microservice_instance_version`: The version of the Microservice instance (for example, 'main' or 'review-<pull-request-number>'). This is a required input.

- `container_image_tag`: The version (commit-short-shar or tag) of the Docker image to be used for tagging and publishing the image. This is a required input.

## Usage

To use this action, you need to set it up in your workflow file (e.g., `deploy.yml`):

```yaml
- name: Deploy Microservice
  uses: plantoncloud/gh-action-deploy-microservice@main
  with:
    planton_cloud_environment_name: '<environment-name>'
    planton_cloud_microservice_instance_version: '<microservice-instance-version>'
    container_image_tag: '<container-image-tag>'
```

Replace `<environment-name>`, `<microservice-instance-version>`, and `<container-image-tag>` with the actual values.

## Support

If you encounter any issues or require further assistance, please file an issue in this GitHub repository.

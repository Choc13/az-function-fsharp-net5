#!/usr/bin/env bash

# Deploys the infrastructure and function app to Azure.
#
# Usage:
#  $ ./deploy.sh <function-publish-folder> -g|--resource-group <resource-group-name>
# * -g|--resource-group: The name of the resource group to deploy to

set -e

POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -g|--resource-group)
      RESOURCE_GROUP="$2"
      shift # past argument
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

# Get function name as output here
FUNCTION_NAME=$(az deployment group create \
    --no-prompt \
    --output tsv \
    --query properties.outputs.functionName.value \
    --resource-group ${RESOURCE_GROUP} \
    --template-file ./azuredeploy.json)

pushd $1
ZIP_ARCHIVE="./functionapp.zip"
rm ${ZIP_ARCHIVE}
zip -r ${ZIP_ARCHIVE} .
az functionapp deployment source config-zip \
    --resource-group ${RESOURCE_GROUP} \
    --name ${FUNCTION_NAME} \
    --src ${ZIP_ARCHIVE}
popd

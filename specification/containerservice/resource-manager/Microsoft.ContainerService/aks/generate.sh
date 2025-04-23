#!/usr/bin/env bash

# bash options
set -o errexit

if [[ $OSTYPE == "darwin"* ]]; then
    AKS_PREVIEW_VENDORED_SDK_PATH=${1:-"/Volumes/SN/Users/fuming/azure-cli-extensions/src/aks-preview/azext_aks_preview/vendored_sdks/azure_mgmt_preview_aks"}
else
    AKS_PREVIEW_VENDORED_SDK_PATH=${1:-"/home/fumingzhang/azure-cli-extensions/src/aks-preview/azext_aks_preview/vendored_sdks/azure_mgmt_preview_aks"}
fi
echo "AKS_PREVIEW_VENDORED_SDK_PATH: ${AKS_PREVIEW_VENDORED_SDK_PATH}"

SCRIPT_PATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"
echo "SCRIPT_PATH: ${SCRIPT_PATH}"

TMP_SDK_PATH="${SCRIPT_PATH}/tmp_sdk"
echo "TMP_SDK_PATH: ${TMP_SDK_PATH}"
mkdir -p ${TMP_SDK_PATH}
SDK_CONTENT_PATH="${TMP_SDK_PATH}/containerservice/azure-mgmt-containerservice/azure/mgmt/containerservice"

# autorest ${SCRIPT_PATH}/readme.md --python --version-tolerant=false --python-sdks-folder=${TMP_SDK_PATH} --use=@autorest/python@6.32.3
autorest ${SCRIPT_PATH}/readme.md --python --version-tolerant=false --python-sdks-folder=${TMP_SDK_PATH}

rm -rf ${AKS_PREVIEW_VENDORED_SDK_PATH}
mkdir -p ${AKS_PREVIEW_VENDORED_SDK_PATH}
mv ${SDK_CONTENT_PATH}/* ${AKS_PREVIEW_VENDORED_SDK_PATH}
rm -rf ${SDK_CONTENT_PATH}

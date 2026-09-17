---
# No `on:` here — this is a shared component meant to be imported.
description: Steps to generate OIDC token and authenticate GitHub agent workflow
network:
  allowed:
    - defaults
    - "login.microsoftonline.com"
    - "azure.com"
    - "visualstudio.com"
steps:
  - name: Acquire OIDC token for Azure
    id: oidc
    shell: bash
    run: |
      set -euo pipefail
      if ! response=$(curl --fail --silent --show-error --get \
        --data-urlencode 'audience=api://AzureADTokenExchange' \
        --header "Authorization: bearer ${ACTIONS_ID_TOKEN_REQUEST_TOKEN:?}" \
        "${ACTIONS_ID_TOKEN_REQUEST_URL:?}"); then
        echo "::error::Failed to request Azure OIDC token"
        exit 1
      fi
      if ! token=$(jq -er '.value | select(type == "string" and length > 0)' <<< "$response"); then
        echo "::error::OIDC response did not contain a token"
        exit 1
      fi
      masked="${token//%/%25}"
      masked="${masked//$'\r'/%0D}"
      masked="${masked//$'\n'/%0A}"
      printf '::add-mask::%s\n' "$masked"
      (umask 077; printf '%s' "$token" > "/tmp/azure-oidc-token")
---

## Workflow Behavior

Login using Azure CLI Login

- Run `mkdir -p /tmp/gh-aw/agent/.azure`.
- Set env variable AZURE_CONFIG_DIR=/tmp/gh-aw/agent/.azure
- Run `az login --service-principal --username $AZURE_CLIENT_ID --tenant $AZURE_TENANT_ID --federated-token $(cat /tmp/azure-oidc-token) --allow-no-subscriptions 2>&1`
- If authentication fails, call the `noop` safe output with the captured response (labelled `authentication_failed`) and stop further processing.
- If authentication fails with expired OIDC then request new OIDC and reauthenticate using az login.

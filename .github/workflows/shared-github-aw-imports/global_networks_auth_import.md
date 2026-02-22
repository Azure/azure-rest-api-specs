---
# No `on:` here — this is a shared component meant to be imported.
description: Steps to generate OIDC token and authenticate GitHub agent workflow
network:
  allowed:
    - defaults
    - "login.microsoftonline.com"
    - "dev.azure.com"
    - "*.dev.azure.com"
    - "*.applicationinsights.azure.com"
    - "*.visualstudio.com"
    - "management.azure.com"
steps:
  - name: Acquire OIDC token for Azure
    id: oidc
    uses: actions/github-script@v7
    with:
      script: |
        const token = await core.getIDToken('api://AzureADTokenExchange');
        const fs = require('fs');
        fs.writeFileSync('/tmp/azure-oidc-token', token);

  - name: Verify Azure CLI authentication
    shell: bash
    run: |
      set -euo pipefail
      if ! command -v az >/dev/null 2>&1; then
        echo "Azure CLI (az) is not installed on this runner." >&2
        exit 1
      fi

      if [[ -z "${AZURE_CLIENT_ID:-}" || -z "${AZURE_TENANT_ID:-}" || -z "${AZURE_FEDERATED_TOKEN_FILE:-}" ]]; then
        echo "Azure federated authentication variables are missing." >&2
        exit 1
      fi

      FED_TOKEN=$(cat "$AZURE_FEDERATED_TOKEN_FILE")
      if [[ -z "$FED_TOKEN" ]]; then
        echo "Federated token file $AZURE_FEDERATED_TOKEN_FILE is empty." >&2
        exit 1
      fi

      echo "Ensuring Azure CLI session is authenticated using workload identity..."
      az login --service-principal \
        --username "$AZURE_CLIENT_ID" \
        --tenant "$AZURE_TENANT_ID" \
        --federated-token "$FED_TOKEN" \
        --allow-no-subscriptions >/tmp/az-login.json

      if az account show --output json > /tmp/az-account.json 2>/tmp/az-account.err; then
        echo "Azure CLI authentication verified. Active subscription (if any):"
        jq -r '"- " + (.name // "No subscription") + " (" + (.id // "n/a") + ")"' /tmp/az-account.json || cat /tmp/az-account.json
      else
        echo "Unable to verify Azure CLI login status:" >&2
        cat /tmp/az-account.err >&2 || true
        exit 1
      fi
---

## Workflow Behavior

Login using Azure CLI Login

- Run `mkdir -p /tmp/gh-aw/agent/.azure`.
- Set env variable AZURE_CONFIG_DIR=/tmp/gh-aw/agent/.azure
- Run `az login --service-principal --username $AZURE_CLIENT_ID --tenant $AZURE_TENANT_ID --federated-token $(cat /tmp/azure-oidc-token) --allow-no-subscriptions 2>&1`
- If authentication fails, call the `noop` safe output with the captured response (labelled `authentication_failed`) and stop further processing.

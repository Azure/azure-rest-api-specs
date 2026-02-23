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
  - name: Fetch secret from Azure Key Vault
    id: fetch_secret
    shell: bash
    run: |
      set -euo pipefail
      AZURE_SDK_PAT_SECRET_VALUE=$(az keyvault secret show --vault-name "AzureSDKEngKeyVault" --name "azuresdk-github-pat" --query value -o tsv)
      AZURE_SDK_COPILOT_PAT_SECRET_VALUE=$(az keyvault secret show --vault-name "AzureSDKEngKeyVault" --name "azuresdk-copilot-github-pat" --query value -o tsv)
      echo "::add-mask::${AZURE_SDK_PAT_SECRET_VALUE}"
      echo "::add-mask::${AZURE_SDK_COPILOT_PAT_SECRET_VALUE}"
      echo "AZURESDK_GITHUB_TOKEN=${AZURE_SDK_PAT_SECRET_VALUE}" >> "${GITHUB_ENV}"
      echo "COPILOT_GITHUB_TOKEN=${AZURE_SDK_COPILOT_PAT_SECRET_VALUE}" >> "${GITHUB_ENV}"
      echo "Secret copied to COPILOT_GITHUB_TOKEN environment variable"

  - name: Install GitHub CLI
    shell: bash
    run: |
      set -euo pipefail
      if ! command -v gh >/dev/null 2>&1; then
        echo "GitHub CLI is required." >&2
        exit 1
      fi
      gh extension install github/gh-aw

  - name: Persist COPILOT_GITHUB_TOKEN as repo secret
    shell: bash
    env:
      GH_TOKEN: ${{ env.AZURESDK_GITHUB_TOKEN }}
    run: |
      set -euo pipefail
      if [[ -z "${COPILOT_GITHUB_TOKEN:-}" ]]; then
        echo "COPILOT_GITHUB_TOKEN environment variable is not set." >&2
        exit 1
      fi

      if [[ -z "${GH_TOKEN:-}" ]]; then
        echo "GH_TOKEN environment variable is not available for gh CLI authentication." >&2
        exit 1
      fi

      gh config set prompt disabled >/dev/null
      pushd "${GITHUB_WORKSPACE}" >/dev/null
      gh aw secrets set COPILOT_GITHUB_TOKEN --value "${COPILOT_GITHUB_TOKEN}"
      popd >/dev/null
---

## Workflow Behavior

Login using Azure CLI Login

- Run `mkdir -p /tmp/gh-aw/agent/.azure`.
- Set env variable AZURE_CONFIG_DIR=/tmp/gh-aw/agent/.azure
- Run `az login --service-principal --username $AZURE_CLIENT_ID --tenant $AZURE_TENANT_ID --federated-token $(cat /tmp/azure-oidc-token) --allow-no-subscriptions 2>&1`
- If authentication fails, call the `noop` safe output with the captured response (labelled `authentication_failed`) and stop further processing.

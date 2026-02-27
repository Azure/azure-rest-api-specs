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
---

## Workflow Behavior

Login using Azure CLI Login

- Run `mkdir -p /tmp/gh-aw/agent/.azure`.
- Set env variable AZURE_CONFIG_DIR=/tmp/gh-aw/agent/.azure
- Run `az login --service-principal --username $AZURE_CLIENT_ID --tenant $AZURE_TENANT_ID --federated-token $(cat /tmp/azure-oidc-token) --allow-no-subscriptions 2>&1`
- If authentication fails, call the `noop` safe output with the captured response (labelled `authentication_failed`) and stop further processing.

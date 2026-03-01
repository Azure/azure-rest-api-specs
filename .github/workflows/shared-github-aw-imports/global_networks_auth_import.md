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
  - name: Azure Login with Workload Identity Federation
    uses: azure/login@v2
    with:
      client-id: "c277c2aa-5326-4d16-90de-98feeca69cbc"
      tenant-id: "72f988bf-86f1-41af-91ab-2d7cd011db47"
      allow-no-subscriptions: true
---

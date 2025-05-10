# Azure AI Agents SDK

> see https://aka.ms/autorest

Configuration for generating Azure AI Agents SDK.

The current release is `latest`.

``` yaml

tag: latest
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release v1
These settings apply only when `--tag=v1` is specified on the command line.
``` yaml $(tag) == 'latest'
input-file:
  - stable/v1/azure-ai-agents.json
```

### Release v2025-05-01
These settings apply only when `--tag=v025-05-01` is specified on the command line.
``` yaml $(tag) == '2025-05-01'
input-file:
  - stable/2025-05-01/azure-ai-agents.json
```

### Release v2025-05-15-preview
These settings apply only when `--tag=2025-05-15-preview` is specified on the command line.
``` yaml $(tag) == '2025-05-15-preview'
input-file:
  - preview/2025-05-15-preview/azure-ai-agents.json
```

# Suppressions
``` yaml
suppressions:
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/files"].get.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/files"].post.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/files/{fileId}"].get.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/files"].delete.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
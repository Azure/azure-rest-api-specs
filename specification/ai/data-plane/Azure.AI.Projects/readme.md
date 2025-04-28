# Azure AI Projects SDK

> see https://aka.ms/autorest

Configuration for generating Azure AI Projects SDK.

The current release is `latest`.

``` yaml

tag: latest
add-credentials: true
openapi-type: data-plane
```

# Releases

### Release latest
These settings apply only when `--tag=latest` is specified on the command line.
``` yaml $(tag) == 'latest'
input-file:
  - stable/latest/azure-ai-projects-1dp.json
```

### Release v2025-05-01
These settings apply only when `--tag=v025-05-01` is specified on the command line.
``` yaml $(tag) == '2025-05-01'
input-file:
  - stable/2025-05-01/azure-ai-projects-1dp.json
```

### Release v2025-05-15-preview
These settings apply only when `--tag=2025-05-15-preview` is specified on the command line.
``` yaml $(tag) == '2025-05-15-preview'
input-file:
  - preview/2025-05-15-preview/azure-ai-projects-1dp.json
```

# Suppressions
``` yaml
suppressions:
  - code: OperationIdNounVerb
    from: azure-ai-projects-1dp.json
    where: $.paths["/evaluations/runs:runAgent"].post.operationId
    reason: False alert. Evaluation should appear after underscore for clarity's sake.
```

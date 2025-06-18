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
    where: $.paths["/files/{fileId}"].delete.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/files/{fileId}/content"].get.operationId
    reason: False alert. Files should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads"].get.operationId
    reason: False alert. Threads should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads"].post.operationId
    reason: False alert. Threads should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}"].get.operationId
    reason: False alert. Threads should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}"].post.operationId
    reason: False alert. Threads should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}"].delete.operationId
    reason: False alert. Threads should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/messages"].get.operationId
    reason: False alert. Messages should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/messages"].post.operationId
    reason: False alert. Messages should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/messages/{messageId}"].get.operationId
    reason: False alert. Messages should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/messages/{messageId}"].post.operationId
    reason: False alert. Messages should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs"].get.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs"].post.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}"].get.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}"].post.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}/cancel"].post.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}/submit_tool_outputs"].post.operationId
    reason: False alert. Runs should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}/steps"].get.operationId
    reason: False alert. RunSteps should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/threads/{threadId}/runs/{runId}/steps/{stepId}"].get.operationId
    reason: False alert. RunSteps should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores"].get.operationId
    reason: False alert. VectorStores should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores"].post.operationId
    reason: False alert. VectorStores should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}"].get.operationId
    reason: False alert. VectorStores should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}"].post.operationId
    reason: False alert. VectorStores should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}"].delete.operationId
    reason: False alert. VectorStores should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}/files"].get.operationId
    reason: False alert. VectorStoreFiles should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}/files"].post.operationId
    reason: False alert. VectorStoreFiles should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}/files/{fileId}"].get.operationId
    reason: False alert. VectorStoreFiles should appear after underscore for clarity's sake.
  - code: OperationIdNounVerb
    from: azure-ai-agents.json
    where: $.paths["/vector_stores/{vectorStoreId}/files/{fileId}"].delete.operationId
    reason: False alert. VectorStoreFiles should appear after underscore for clarity's sake.

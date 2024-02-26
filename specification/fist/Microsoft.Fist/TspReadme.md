
``` yaml

isAzureSpec: true
isArm: true
require: https://raw.githubusercontent.com/Azure/azure-rest-api-specs/9327aa86338ea6699a61a251e1b6b7c87d164306/specification/fist/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false
use-model-reader-writer: true

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

```
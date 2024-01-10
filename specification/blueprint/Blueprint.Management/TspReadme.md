

``` yaml

library-name: Blueprint
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/4270cc435fd2496bdb2a5f056dbddb463e52c7c2/specification/blueprint/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


list-exception:
  - /{resourceScope}/providers/Microsoft.Blueprint/blueprints/{blueprintName}/versions/{versionId}

rename-mapping:
  AssignmentJobCreatedResource: AssignmentJobCreatedResult

```

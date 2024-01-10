

```yaml
library-name: Chaos
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/eb29c07a0f08110c932b384d5dc41241dc0b03ab/specification/chaos/resource-manager/readme.md
skip-csproj: true
modelerfour:
    flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```

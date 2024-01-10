

``` yaml

library-name: Elastic
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/7d5d1db0c45d6fe0934c97b6a6f9bb34112d42d1/specification/elastic/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


rename-mapping:
  MonitoredResource: MonitoredResourceContent

```

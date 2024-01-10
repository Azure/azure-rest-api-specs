

``` yaml

library-name: CustomerInsights
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/066eb8c81e14e0f3b22b6700c67693eef5f79ea9/specification/customer-insights/resource-manager/readme.md
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

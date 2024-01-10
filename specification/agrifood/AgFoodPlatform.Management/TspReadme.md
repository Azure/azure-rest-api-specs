

``` yaml

library-name: AgFoodPlatform
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/tree/e31e3938529269e0e6a81f60b2fdc6d2aec5b9df/specification/agrifood/resource-manager/readme.md
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

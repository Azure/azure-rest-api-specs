

``` yaml
library-name: ServiceNetworking
isAzureSpec: true
isArm: true
require: https://raw.githubusercontent.com/Azure/azure-rest-api-specs/9837baba3ca259b4f2a3f736593311f445c35c63/specification/servicenetworking/resource-manager/readme.md
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



``` yaml

library-name: SecurityDevOps
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/886cb1c95499e7577e14ba1b4317f63590d79992/specification/securitydevops/resource-manager/readme.md
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

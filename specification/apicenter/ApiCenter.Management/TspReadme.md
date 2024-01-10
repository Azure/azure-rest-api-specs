

``` yaml
library-name: ApiCenter
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/a29126ca8200a6c981a4e908e41fe55730df4cad/specification/apicenter/resource-manager/readme.md
#tag: package-2023-07-01-preview
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug: 
#  show-serialized-names: true

rename-mapping:
  ServiceCollection: ApiCenterServiceListResult

prepend-rp-prefix:
  - ProvisioningState
  - Service

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```

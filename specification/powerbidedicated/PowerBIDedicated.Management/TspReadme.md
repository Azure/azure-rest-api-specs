

``` yaml

library-name: PowerBIDedicated
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/34ba022add0034e30462b76e1548ce5a7e053e33/specification/powerbidedicated/resource-manager/readme.md
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
  SkuDetailsForExistingResource: SkuDetails

```

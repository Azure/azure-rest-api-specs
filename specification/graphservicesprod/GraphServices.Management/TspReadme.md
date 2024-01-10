

``` yaml
library-name: GraphServices
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/fe056966cf070be84e92dd2dc1b566bae35002cf/specification/graphservicesprod/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


rename_mapping:
  AccountResourceProperties.appId: -|uuid
  AccountResourceProperties.billingPlanId: -|uuid

prepend-rp-prefix:
    - ProvisioningState
    - AccountResource
    - AccountResourceList
    - AccountPatchResource
    - AccountResourceProperties
    - TagUpdate
    
directive:
    - remove-operation: 'Operation_List'

```

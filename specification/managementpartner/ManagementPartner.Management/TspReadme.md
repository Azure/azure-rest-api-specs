

``` yaml

library-name: ManagementPartner
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/7d5d1db0c45d6fe0934c97b6a6f9bb34112d42d1/specification/managementpartner/resource-manager/readme.md
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
  - /providers/Microsoft.ManagementPartner/partners/{partnerId}

directive:
  # This definistion of this operation is wrong
  - from: ManagementPartner.json
    where: $.paths
    transform: >
      delete $['/providers/Microsoft.ManagementPartner/partners'];
```

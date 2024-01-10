

``` yaml

library-name: Maps
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/6b08774c89877269e73e11ac3ecbd1bd4e14f5a0/specification/maps/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  CreatorList: MapsCreatorListResult
  Kind: MapsAccountKind
  Name: MapsSkuName
  MapsAccountProperties.uniqueId: -|uuid
  MapsAccountUpdateParameters.properties.uniqueId: -|uuid
  MapsAccountKeys.primaryKeyLastUpdated: primaryKeyLastUpdatedOn|date-time
  MapsAccountKeys.secondaryKeyLastUpdated: secondaryKeyLastUpdatedOn|date-time

prepend-rp-prefix:
  - Creator
  - CreatorProperties
  - KeyType
  - LinkedResource
  - SigningKey
  - CorsRule

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - remove-operation: 'Maps_ListOperations'
  - remove-operation: 'Maps_ListSubscriptionOperations'

```



``` yaml

library-name: ExtendedLocations
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/691920cda83cc0b89a8c821d0bb285100fad22b4/specification/extendedlocation/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  CustomLocationPropertiesAuthentication: CustomLocationAuthentication
  EnabledResourceType: CustomLocationEnabledResourceType
  EnabledResourceTypePropertiesTypesMetadataItem: CustomLocationEnabledResourceTypeMetadata
  EnabledResourceTypesListResult: CustomLocationEnabledResourceTypesResult
  HostType: CustomLocationHostType

format-by-name-rules:
  'tenantId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'
  'clusterExtensionIds': 'arm-id'
  'clusterExtensionId': 'arm-id'
  'HostResourceId': 'arm-id'


directive:
  - remove-operation: 'CustomLocations_ListOperations'
```

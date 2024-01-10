

``` yaml

library-name: EnergyServices
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/2feaf7f24cc26a7274c9fd79015ae62b1d273986/specification/oep/resource-manager/readme.md
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
  DataPartitionAddOrRemoveRequest: DataPartitionAddOrRemoveContent
  CheckNameAvailabilityRequest: EnergyServiceNameAvailabilityContent
  CheckNameAvailabilityReason: EnergyServiceNameUnavailableReason
  CheckNameAvailabilityResponse: EnergyServiceNameAvailabilityResult
  DataPartitionProperties: DataPartition
  DataPartitionNames: DataPartitionName
```

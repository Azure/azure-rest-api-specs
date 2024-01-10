

``` yaml

library-name: MixedReality
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/aa8a23b8f92477d0fdce7af6ccffee1c604b3c56/specification/mixedreality/resource-manager/readme.md
tag: package-2021-01
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  AccountKeyRegenerateRequest: MixedRealityAccountKeyRegenerateContent
  AccountKeys: MixedRealityAccountKeys
  CheckNameAvailabilityRequest: MixedRealityNameAvailabilityContent
  CheckNameAvailabilityResponse: MixedRealityNameAvailabilityResult
  NameUnavailableReason: MixedRealityNameUnavailableReason
  RemoteRenderingAccountPage: RemoteRenderingAccountListResult
  SpatialAnchorsAccountPage: SpatialAnchorsAccountListResult
  Serial: MixedRealityAccountKeySerial
  SpatialAnchorsAccount.properties.accountId: -|uuid
  RemoteRenderingAccount.properties.accountId: -|uuid
  CheckNameAvailabilityResponse.nameAvailable: IsNameAvailable

override-operation-name:
  CheckNameAvailabilityLocal: CheckMixedRealityNameAvailability

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


```

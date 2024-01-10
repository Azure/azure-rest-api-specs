

``` yaml

library-name: Search
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/b934efa9501672e73686c2adbc7a4dcdd26e86c2/specification/search/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  AadAuthFailureMode: SearchAadAuthFailureMode
  AdminKeyKind: SearchServiceAdminKeyKind
  AdminKeyResult: SearchServiceAdminKeyResult
  CheckNameAvailabilityInput: SearchServiceNameAvailabilityContent
  CheckNameAvailabilityOutput: SearchServiceNameAvailabilityResult
  DataPlaneAuthOptions: SearchAadAuthDataPlaneAuthOptions
  EncryptionWithCmk: SearchEncryptionWithCmk
  HostingMode: SearchServiceHostingMode
  IpRule: SearchServiceIPRule
  PrivateEndpointConnectionProperties: SearchServicePrivateEndpointConnectionProperties
  PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState: SearchServicePrivateLinkServiceConnectionState
  PrivateLinkServiceConnectionStatus: SearchServicePrivateLinkServiceConnectionStatus
  PrivateLinkServiceConnectionProvisioningState: SearchPrivateLinkServiceConnectionProvisioningState
  ProvisioningState: SearchServiceProvisioningState
  PublicNetworkAccess: SearchServicePublicNetworkAccess
  QueryKey: SearchServiceQueryKey
  ResourceType: SearchServiceResourceType
  SearchEncryptionWithCmk: SearchEncryptionWithCmkEnforcement
  SearchService.properties.disableLocalAuth: isLocalAuthDisabled
  SearchServiceUpdate.properties.disableLocalAuth: isLocalAuthDisabled
  ShareablePrivateLinkResourceProperties: ShareableSearchServicePrivateLinkResourceProperties
  ShareablePrivateLinkResourceType: ShareableSearchServicePrivateLinkResourceType
  SharedPrivateLinkResource: SharedSearchServicePrivateLinkResource
  SharedPrivateLinkResourceProperties: SharedSearchServicePrivateLinkResourceProperties
  SharedPrivateLinkResourceProperties.privateLinkResourceId: -|arm-id
  SharedPrivateLinkResourceProperties.resourceRegion: -|azure-location
  SharedPrivateLinkResourceProvisioningState: SharedSearchServicePrivateLinkResourceProvisioningState
  SharedPrivateLinkResourceStatus: SharedSearchServicePrivateLinkResourceStatus
  UnavailableNameReason: SearchServiceNameUnavailableReason
  

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


override-operation-name:
  Services_CheckNameAvailability: CheckSearchServiceNameAvailability

# Remove "stopped" enum from SearchServiceStatus

directive:
  - from: search.json
    where: $.definitions.SearchServiceProperties.properties.status
    transform: >
      $.enum.includes('stopped') ? $.enum.splice($.enum.indexOf('stopped'), 1) : undefined;
      $['x-ms-enum'].values.map(e => e.value).includes('stopped') ? $['x-ms-enum'].values.splice($['x-ms-enum'].values.map(e => e.value).indexOf('stopped'), 1) : undefined;
  - from: search.json
    where: $.definitions
    transform: >
      $.QuotaUsageResult.properties.id['x-ms-format'] = 'arm-id';
```

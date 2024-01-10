

``` yaml

library-name: DigitalTwins
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/71e8a754d34d1af32bf81f23445f286422ca4c40/specification/digitaltwins/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false
deserialize-null-collection-as-null-value: true

rename-mapping:
  AzureDataExplorerConnectionProperties.adxResourceId: -|arm-id
  AzureDataExplorerConnectionProperties.eventHubNamespaceResourceId: -|arm-id
  CheckNameResult.nameAvailable: IsNameAvailable
  CheckNameRequest.type: ResourceType
  AuthenticationType: DigitalTwinsAuthenticationType
  ProvisioningState: DigitalTwinsProvisioningState
  PublicNetworkAccess: DigitalTwinsPublicNetworkAccess
  GroupIdInformation: DigitalTwinsPrivateLinkResource
  GroupIdInformationProperties: DigitalTwinsPrivateLinkResourceProperties
  ConnectionProperties: DigitalTwinsPrivateEndpointConnectionProperties
  AzureDataExplorerConnectionProperties: DataExplorerConnectionProperties
  CheckNameResult: DigitalTwinsNameResult
  CheckNameRequest: DigitalTwinsNameContent
  Reason: DigitalTwinsNameUnavailableReason
  ConnectionState: DigitalTwinsPrivateLinkServiceConnectionState
  PrivateLinkServiceConnectionStatus: DigitalTwinsPrivateLinkServiceConnectionStatus
  ConnectionPropertiesProvisioningState: DigitalTwinsPrivateLinkResourceProvisioningState
  EndpointProvisioningState: DigitalTwinsEndpointProvisioningState
  EventGrid: DigitalTwinsEventGridProperties
  EventHub: DigitalTwinsEventHubProperties
  ServiceBus: DigitalTwinsServiceBusProperties
  ResourceType: DigitalTwinsResourceType
  ManagedIdentityReference: DigitalTwinsManagedIdentityReference
  IdentityType: DigitalTwinsManagedIdentityType

override-operation-name:
  PrivateLinkResources_Get: GetPrivateLinkResourceGroupIdInformation
  DigitalTwins_CheckNameAvailability: CheckDigitalTwinsNameAvailability

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - from: digitaltwins.json
    where: $.definitions
    transform: >
      $.CheckNameRequest.properties.type['x-ms-enum']['name'] = 'ResourceType';
      $.ConnectionProperties.properties.privateLinkServiceConnectionState = {
            'description': 'The connection state.',
            '$ref': '#/definitions/ConnectionState'
          };
```

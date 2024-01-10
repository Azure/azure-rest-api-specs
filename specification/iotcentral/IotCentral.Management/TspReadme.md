

``` yaml

library-name: IotCentral
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/6cb07747e61d4068750cb2666ab1b32197037dbf/specification/iotcentral/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

override-operation-name:
  Apps_CheckNameAvailability: CheckIotCentralAppNameAvailability
  Apps_CheckSubdomainAvailability: CheckIotCentralAppSubdomainAvailability

rename-mapping:
  AppAvailabilityInfo.nameAvailable: IsNameAvailable
  AppTemplateLocations: IotCentralAppTemplateLocation
  OperationInputs: IotCentralAppNameAvailabilityContent
  AppAvailabilityInfo: IotCentralAppNameAvailabilityResponse
  AppAvailabilityInfo.reason: IotCentralAppNameUnavailableReason
  NetworkRuleSets.applyToIoTCentral: ApplyToIotCentral
  AppTemplateLocations.id: location

prepend-rp-prefix:
  - App
  - Applications
  - AppListResult
  - AppSku
  - AppSkuInfo
  - AppState
  - AppTemplate
  - AppTemplatesResult
  - NetworkAction
  - NetworkRuleSetIpRule
  - NetworkRuleSets
  - ProvisioningState
  - PublicNetworkAccess

format-by-name-rules:
  'tenantId': 'uuid'
  'applicationId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - from: iotcentral.json
    where: $.definitions
    transform: >
      $.AppTemplate.properties.order['type'] = 'integer';

```

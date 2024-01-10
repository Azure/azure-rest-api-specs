

``` yaml
library-name: ResourceConnector
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/616302e10e5ce0f80d2f0eaf8002f3e39d033696/specification/resourceconnector/resource-manager/readme.md
#tag: package-2022-10-27
skip-csproj: true
modelerfour:
  flatten-payloads: false

#mgmt-debug: 
#  show-serialized-names: true

prepend-rp-prefix:
  - Appliance
  - Distro
  - Status

rename-mapping:
  ApplianceGetTelemetryConfigResult: ApplianceTelemetryConfigResult
  ApplianceListCredentialResults: ApplianceClusterUserCredentialResult
  ApplianceListKeysResults: ApplianceClusterUserKeysResult
  ArtifactProfile: ApplianceArtifactProfile
  Distro.AKSEdge: AksEdge
  Provider: ApplianceProvider
  Provider.VMWare: VMware
  Provider.HCI: Hci
  SSHKey: ApplianceSshKey
  SupportedVersion: ApplianceSupportedVersion
  SupportedVersionCatalogVersion: ApplianceSupportedVersionCatalogVersion
  SupportedVersionCatalogVersionData: ApplianceSupportedVersionCatalogVersionProperties
  SupportedVersionMetadata: ApplianceSupportedVersionMetadata
  UpgradeGraph: ApplianceUpgradeGraph
  UpgradeGraphProperties: ApplianceUpgradeGraphProperties

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


directive:
  - remove-operation: Appliances_ListOperations
```

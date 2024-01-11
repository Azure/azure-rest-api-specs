``` yaml
library-name: ElasticSan
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/afa158ef56a05f6603924f4a493817cec332b113/specification/elasticsan/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


prepend-rp-prefix:
  - EncryptionType
  - Name
  - Tier
  - Volume
  - VolumeCreateOption
  - VolumeGroup
  - VolumeGroupList
  - VolumeList
  - SkuInformationList
  - SkuLocationInfo
  - Snapshot

rename-mapping:
  Volume.properties.volumeId: -|uuid
  VirtualNetworkRule.id: -|arm-id
  Action: ElasticSanVirtualNetworkRuleAction
  OperationalStatus: ResourceOperationalStatus
  ProvisioningStates: ElasticSanProvisioningState
  State: ElasticSanVirtualNetworkRuleState
  SKUCapability: ElasticSanSkuCapability
  SourceCreationData: ElasticSanVolumeDataSourceInfo
  VirtualNetworkRule: ElasticSanVirtualNetworkRule

directive:
- from: elasticsan.json
  where: $.definitions.SourceCreationData.properties.sourceId
  transform: $["x-ms-format"] = "arm-id";
- from: elasticsan.json
  where: $.definitions.SnapshotCreationData.properties.sourceId
  transform: $["x-ms-format"] = "arm-id";
- from: elasticsan.json
  where: $.definitions.ManagedByInfo.properties.resourceId
  transform: $["x-ms-format"] = "arm-id";
```

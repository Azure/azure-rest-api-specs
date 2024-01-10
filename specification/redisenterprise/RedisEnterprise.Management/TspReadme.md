

``` yaml

library-name: RedisEnterprise
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/969fd0c2634fbcc1975d7abe3749330a5145a97c/specification/redisenterprise/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

rename-mapping:
  Cluster: RedisEnterpriseCluster
  ClusterList: RedisEnterpriseClusterList
  ClusterUpdate: RedisEnterpriseClusterUpdate
  ResourceState: RedisEnterpriseClusterResourceState
  Database: RedisEnterpriseDatabase
  DatabaseList: RedisEnterpriseDatabaseList
  AccessKeys: RedisEnterpriseDataAccessKeys
  AccessKeyType: RedisEnterpriseAccessKeyType
  Capability: RedisEnterpriseCapability
  ClusterPropertiesEncryptionCustomerManagedKeyEncryption: RedisEnterpriseCustomerManagedKeyEncryption
  ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity: RedisEnterpriseCustomerManagedKeyEncryptionKeyIdentity
  CmkIdentityType: RedisEnterpriseCustomerManagedKeyIdentityType
  LocationInfo: RedisEnterpriseLocationInfo
  RegionSkuDetail: RedisEnterpriseRegionSkuDetail
  FlushParameters: FlushRedisEnterpriseDatabaseParameters
  ClusteringPolicy: RedisEnterpriseClusteringPolicy
  TlsVersion: RedisEnterpriseTlsVersion
  RegenerateKeyParameters: RedisEnterpriseRegenerateKeyParameters
  SkuName: RedisEnterpriseSkuName
  Sku: RedisEnterpriseSku
  PrivateLinkServiceConnectionState: RedisEnterprisePrivateLinkServiceConnectionState
  PrivateLinkResourceListResult: RedisEnterprisePrivateLinkResourceListResult
  PrivateLinkResource: RedisEnterprisePrivateLinkResource
  PrivateEndpointServiceConnectionStatus: RedisEnterprisePrivateEndpointServiceConnectionStatus
  PrivateEndpointConnectionProvisioningState: RedisEnterprisePrivateEndpointConnectionProvisioningState
  PrivateEndpointConnectionListResult: RedisEnterprisePrivateEndpointConnectionListResult
  PrivateEndpointConnection: RedisEnterprisePrivateEndpointConnection
  Persistence: RedisPersistenceSettings
  AofFrequency.1s: OneSecond
  AofFrequency: PersistenceSettingAofFrequency
  RdbFrequency.1h: OneHour
  RdbFrequency.6h: SixHours
  RdbFrequency.12h: TwelveHours
  RdbFrequency: PersistenceSettingRdbFrequency
  DatabasePropertiesGeoReplication: RedisEnterpriseDatabaseGeoReplication
  LinkedDatabase: RedisEnterpriseLinkedDatabase
  LinkState: RedisEnterpriseDatabaseLinkState
  ProvisioningState: RedisEnterpriseProvisioningStatus
  EvictionPolicy: RedisEnterpriseEvictionPolicy
  OperationStatus: RedisEnterpriseOperationStatus
  ExportClusterParameters: ExportRedisEnterpriseDatabaseParameters
  ImportClusterParameters: ImportRedisEnterpriseDatabaseParameters
  ForceUnlinkParameters: ForceUnlinkRedisEnterpriseDatabaseParameters
  Module: RedisEnterpriseModule
  Protocol: RedisEnterpriseClientProtocol
  Persistence.aofEnabled: IsAofEnabled
  Persistence.rdbEnabled: IsRdbEnabled
  Protocol.Plaintext: PlainText
  ForceUnlinkParameters.ids: -|arm-id
  ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity.userAssignedIdentityResourceId: -|arm-id
  LinkedDatabase.id: -|arm-id
  OperationStatus.id: -|arm-id
  RegionSkuDetail.resourceType: -|resource-type

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'

# mgmt-debug:
#   show-serialized-names: true


override-operation-name:
  OperationsStatus_Get: GetRedisEnterpriseOperationsStatus
  Skus_List: GetRedisEnterpriseSkus

directive:
  - from: redisenterprise.json
    where: $.definitions
    transform: >
      $.OperationStatus.properties.error['x-ms-client-name'] = 'ErrorResponse';
      $.OperationStatus.properties.startTime['format'] = 'date-time';
      $.OperationStatus.properties.endTime['format'] = 'date-time';

```

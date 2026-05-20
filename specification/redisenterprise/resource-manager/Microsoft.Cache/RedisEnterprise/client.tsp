import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "javascript");
@@clientName(Microsoft.Cache, "RedisEnterpriseManagementClient", "python");

@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);

// csharp configurations
@@clientName(AccessKeys, "RedisEnterpriseDataAccessKeys", "csharp");
@@clientName(AccessKeyType, "RedisEnterpriseAccessKeyType", "csharp");
@@clientName(AofFrequency.OneS, "OneSecond", "csharp");
@@clientName(AzureCacheForRedisMigrationProperties.switchDns,
  "IsSwitchDns",
  "csharp"
);
@@clientName(AzureCacheForRedisMigrationProperties.skipDataMigration,
  "IsSkipDataMigration",
  "csharp"
);
@@clientName(AofFrequency, "PersistenceSettingAofFrequency", "csharp");
@@clientName(Cluster, "RedisEnterpriseCluster", "csharp");
@@clientName(ClusteringPolicy, "RedisEnterpriseClusteringPolicy", "csharp");
@@clientName(ClusteringPolicy.OSSCluster, "OssCluster", "csharp");
@@clientName(ClusterList, "RedisEnterpriseClusterList", "csharp");
@@clientName(ClusterPropertiesEncryptionCustomerManagedKeyEncryption,
  "RedisEnterpriseCustomerManagedKeyEncryption",
  "csharp"
);
@@clientName(ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity,
  "RedisEnterpriseCustomerManagedKeyEncryptionKeyIdentity",
  "csharp"
);
@@clientName(ClusterUpdate, "RedisEnterpriseClusterUpdate", "csharp");
@@clientName(CmkIdentityType,
  "RedisEnterpriseCustomerManagedKeyIdentityType",
  "csharp"
);
@@clientName(Database, "RedisEnterpriseDatabase", "csharp");
@@clientName(DatabaseList, "RedisEnterpriseDatabaseList", "csharp");
@@clientName(DatabasePropertiesGeoReplication,
  "RedisEnterpriseDatabaseGeoReplication",
  "csharp"
);
@@clientName(EvictionPolicy, "RedisEnterpriseEvictionPolicy", "csharp");
@@clientName(EvictionPolicy.AllKeysLFU, "AllKeysLfu", "csharp");
@@clientName(EvictionPolicy.AllKeysLRU, "AllKeysLru", "csharp");
@@clientName(EvictionPolicy.VolatileLRU, "VolatileLfu", "csharp");
@@clientName(EvictionPolicy.VolatileLFU, "VolatileLru", "csharp");
@@clientName(EvictionPolicy.VolatileTTL, "VolatileTtl", "csharp");
@@clientName(ExportClusterParameters,
  "ExportRedisEnterpriseDatabaseContent",
  "csharp"
);
@@clientName(FlushParameters, "FlushRedisEnterpriseDatabaseContent", "csharp");
@@clientName(ForceLinkParameters, "ForceLinkContent", "csharp");
@@clientName(ForceUnlinkParameters,
  "ForceUnlinkRedisEnterpriseDatabaseContent",
  "csharp"
);
@@clientName(HighAvailability, "RedisEnterpriseHighAvailability", "csharp");
@@clientName(ImportClusterParameters,
  "ImportRedisEnterpriseDatabaseContent",
  "csharp"
);
@@clientName(LinkedDatabase, "RedisEnterpriseLinkedDatabase", "csharp");
@@clientName(LinkState, "RedisEnterpriseDatabaseLinkState", "csharp");
@@clientName(Module, "RedisEnterpriseModule", "csharp");
@@clientName(Migration, "RedisEnterpriseMigration", "csharp");
@@clientName(MaintenanceDayOfWeek,
  "RedisEnterpriseMaintenanceDayOfWeek",
  "csharp"
);
@@clientName(MaintenanceWindow, "RedisEnterpriseMaintenanceWindow", "csharp");
@@clientName(MaintenanceWindowType,
  "RedisEnterpriseMaintenanceWindowType",
  "csharp"
);
@@clientName(MigrationProperties,
  "RedisEnterpriseMigrationProperties",
  "csharp"
);
@@clientName(MigrationProvisioningState,
  "RedisEnterpriseMigrationProvisioningState",
  "csharp"
);
@@clientName(OperationStatus, "RedisEnterpriseOperationStatus", "csharp");
@@clientName(OperationStatus.error, "ErrorResponse", "csharp");
@@clientName(OperationStatus.startTime, "StartOn", "csharp");
@@clientName(OperationStatus.endTime, "EndOn", "csharp");
@@clientName(Persistence.aofEnabled, "IsAofEnabled", "csharp");
@@clientName(Persistence.rdbEnabled, "IsRdbEnabled", "csharp");
@@clientName(Persistence, "RedisPersistenceSettings", "csharp");
@@clientName(PrivateEndpointConnection,
  "RedisEnterprisePrivateEndpointConnection",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(Protocol.Plaintext, "PlainText", "csharp");
@@clientName(Protocol, "RedisEnterpriseClientProtocol", "csharp");
@@clientName(ProvisioningState, "RedisEnterpriseProvisioningStatus", "csharp");
@@clientName(PublicNetworkAccess,
  "RedisEnterprisePublicNetworkAccess",
  "csharp"
);
@@clientName(RdbFrequency.TwelveH, "TwelveHours", "csharp");
@@clientName(RdbFrequency.OneH, "OneHour", "csharp");
@@clientName(RdbFrequency.SixH, "SixHours", "csharp");
@@clientName(RdbFrequency, "PersistenceSettingRdbFrequency", "csharp");
@@clientName(RedundancyMode, "RedisEnterpriseRedundancyMode", "csharp");
@@clientName(RegenerateKeyParameters,
  "RedisEnterpriseRegenerateKeyContent",
  "csharp"
);
@@clientName(ResourceState, "RedisEnterpriseClusterResourceState", "csharp");
@@clientName(Sku, "RedisEnterpriseSku", "csharp");
@@clientName(SkuName, "RedisEnterpriseSkuName", "csharp");
@@clientName(SkuDetails, "RedisEnterpriseSkuDetails", "csharp");
@@clientName(SkuDetailsList, "RedisEnterpriseSkuDetailsList", "csharp");
@@clientName(TlsVersion, "RedisEnterpriseTlsVersion", "csharp");
@@clientName(OperationsStatusOperationGroup.get,
  "GetRedisEnterpriseOperationsStatus",
  "csharp"
);
@@clientName(Clusters.listByCluster,
  "GetPrivateLinkResourcesByCluster",
  "csharp"
);
@@alternateType(MaintenanceWindow.duration, duration, "csharp");
@@alternateType(AccessPolicyAssignmentPropertiesUser.objectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ClusterPropertiesEncryptionCustomerManagedKeyEncryptionKeyIdentity.userAssignedIdentityResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LinkedDatabase.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ForceUnlinkParameters.ids,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(OperationStatus.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(OperationStatus.startTime, utcDateTime, "csharp");
@@alternateType(OperationStatus.endTime, utcDateTime, "csharp");
@@alternateType(ExportClusterParameters.sasUri, url, "csharp");
@@alternateType(ClusterPropertiesEncryptionCustomerManagedKeyEncryption.keyEncryptionKeyUrl,
  url,
  "csharp"
);
// `RedisEnterprise` configured in `back-compatible` has a namespace name conflict, so it is reconfigured here.
@@clientLocation(Clusters.get, "RedisEnterpriseCluster", "csharp");
@@clientLocation(Clusters.create, "RedisEnterpriseCluster", "csharp");
@@clientLocation(Clusters.update, "RedisEnterpriseCluster", "csharp");
@@clientLocation(Clusters.delete, "RedisEnterpriseCluster", "csharp");
@@clientLocation(Clusters.listByResourceGroup,
  "RedisEnterpriseCluster",
  "csharp"
);
@@clientLocation(Clusters.list, "RedisEnterpriseCluster", "csharp");
@@clientLocation(Clusters.listSkusForScaling,
  "RedisEnterpriseCluster",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "csharp"
);

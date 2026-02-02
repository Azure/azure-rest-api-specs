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
@@clientName(AofFrequency, "PersistenceSettingAofFrequency", "csharp");
@@clientName(Cluster, "RedisEnterpriseCluster", "csharp");
@@clientName(ClusteringPolicy, "RedisEnterpriseClusteringPolicy", "csharp");
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
@@clientName(OperationStatus, "RedisEnterpriseOperationStatus", "csharp");
@@clientName(OperationStatus.error, "ErrorResponse", "csharp");
@@clientName(Persistence.aofEnabled, "IsAofEnabled", "csharp");
@@clientName(Persistence.rdbEnabled, "IsRdbEnabled", "csharp");
@@clientName(Persistence, "RedisPersistenceSettings", "csharp");
@@clientName(PrivateEndpointConnection,
  "RedisEnterprisePrivateEndpointConnection",
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
@@clientName(TlsVersion.One0, "Tls1_0", "csharp");
@@clientName(TlsVersion.One1, "Tls1_1", "csharp");
@@clientName(TlsVersion.One2, "Tls1_2", "csharp");
@@clientName(OperationsStatusOperationGroup.get,
  "GetRedisEnterpriseOperationsStatus",
  "csharp"
);
// @@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse.error,
//   "ErrorResponse",
//   "csharp"
// );
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
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(OperationStatus.id, Azure.Core.armResourceIdentifier, "csharp");
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
// Because the generation process prompts the problem of duplicate keys, blocking the content in the west can solve the problem.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties, "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterUpdate.properties, "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Database.properties, "!csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseUpdate.properties, "!csharp");

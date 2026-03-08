import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Cache;

@@clientName(Microsoft.Cache, "RedisManagementClient", "python");
@@clientName(Microsoft.Cache, "RedisManagementClient", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "javascript");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "javascript");

// Go SDK specific customizations to resolve breaking changes
// Fix TLS version naming (Pattern: Naming Changes with Numbers)
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "One0", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "One1", "go");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "One2", "go");
@@clientName(Microsoft.Cache.RedisResource, "ResourceInfo", "go");

// Python SDK specific customizations to resolve breaking changes
@@clientName(Microsoft.Cache.TlsVersion.`1.0`, "ONE0", "python");
@@clientName(Microsoft.Cache.TlsVersion.`1.1`, "ONE1", "python");
@@clientName(Microsoft.Cache.TlsVersion.`1.2`, "ONE2", "python");

// Java SDK specific customizations to resolve breaking changes
@@clientName(RedisCommonPropertiesRedisConfiguration,
  "RedisConfiguration",
  "java"
);
@@clientName(RedisCreateProperties.staticIP, "staticIp", "java");
@@clientName(RedisProperties.hostName, "hostname", "java");
@@clientName(ImportRDBParameters, "ImportRdbParameters", "java");
@@clientName(ExportRDBParameters, "ExportRdbParameters", "java");
@@clientName(RedisFirewallRuleProperties.startIP, "startIp", "java");
@@clientName(RedisFirewallRuleProperties.endIP, "endIp", "java");
@@clientName(RedisLinkedServerCreateProperties.primaryHostName,
  "primaryHostname",
  "java"
);
@@clientName(RedisLinkedServerCreateProperties.geoReplicatedPrimaryHostName,
  "geoReplicatedPrimaryHostname",
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility for C# SDK"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility for C# SDK"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "csharp"
);
// Fix Java SDK handwritten code
@@usage(RedisResource, Usage.input | Usage.output, "java");
@@usage(RedisFirewallRuleCreateParameters, Usage.input, "java");

@@clientName(RedisCommonPropertiesRedisConfiguration,
  "RedisCommonConfiguration",
  "csharp"
);

@@clientName(RedisCommonPropertiesRedisConfiguration.`rdb-backup-enabled`,
  "IsRdbBackupEnabled",
  "csharp"
);
@@alternateType(RedisCommonPropertiesRedisConfiguration.`rdb-backup-enabled`,
  boolean,
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aof-backup-enabled`,
  "IsAofBackupEnabled",
  "csharp"
);
@@alternateType(RedisCommonPropertiesRedisConfiguration.`aof-backup-enabled`,
  boolean,
  "csharp"
);
@@alternateType(RedisCommonPropertiesRedisConfiguration.`rdb-backup-max-snapshot-count`,
  int32,
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aad-enabled`,
  "IsAadEnabled",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.authnotrequired,
  "AuthNotRequired",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.maxclients,
  "MaxClients",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-delta`,
  "MaxMemoryDelta",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-reserved`,
  "MaxMemoryReserved",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-policy`,
  "MaxMemoryPolicy",
  "csharp"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxfragmentationmemory-reserved`,
  "MaxFragmentationMemoryReserved",
  "csharp"
);
@@clientName(RedisCommonProperties.disableAccessKeyAuthentication,
  "IsAccessKeyAuthenticationDisabled",
  "csharp"
);
@@clientName(ScheduleEntries, "RedisPatchScheduleSettings", "csharp");
@@clientName(ScheduleEntry, "RedisPatchScheduleSetting", "csharp");
@@clientName(DefaultName, "RedisPatchScheduleDefaultName", "csharp");
@@clientName(UpgradeNotification, "RedisUpgradeNotification", "csharp");
@@clientName(NotificationListResponse,
  "RedisUpgradeNotificationListResponse",
  "csharp"
);
@@clientName(RedisKeyType, "RedisRegenerateKeyType", "csharp");
@@clientName(ReplicationRole, "RedisLinkedServerRole", "csharp");
@@clientName(RedisForceRebootResponse, "RedisForceRebootResult", "csharp");
@@clientName(SkuFamily.C, "BasicOrStandard", "csharp");
@@clientName(SkuFamily.P, "Premium", "csharp");
@@clientName(CheckNameAvailabilityParameters,
  "RedisNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters.type, "resourceType", "csharp");
@@alternateType(CheckNameAvailabilityParameters.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(RedisCacheAccessPolicyAssignmentProperties.objectId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(OperationStatus, "RedisOperationStatus", "csharp");
@@clientName(ProvisioningState, "RedisProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "RedisPublicNetworkAccess", "csharp");
@@clientName(RebootType, "RedisRebootType", "csharp");
@@clientName(DayOfWeek, "RedisDayOfWeek", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "RedisPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.provisioningState,
  "RedisProvisioningState",
  "csharp"
);
@@scope(Operations.list, "!csharp");
@@clientName(RedisResource, "Redis", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkResource,
  "RedisPrivateLinkResource",
  "csharp"
);
@@clientName(ExportRDBParameters, "ExportRdbContent", "csharp");
@@clientName(ImportRDBParameters, "ImportRdbContent", "csharp");

@@clientName(RedisLinkedServerCreateParameters,
  "RedisLinkedServerWithPropertyCreateOrUpdateContent",
  "csharp"
);
@@clientName(RedisCreateParameters, "RedisCreateOrUpdateContent", "csharp");
@@clientName(RedisRebootParameters, "RedisRebootContent", "csharp");
@@clientName(RedisRegenerateKeyParameters,
  "RedisRegenerateKeyContent",
  "csharp"
);
@@alternateType(RedisCreateProperties.staticIP,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(RedisFirewallRuleProperties.startIP,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(RedisFirewallRuleProperties.endIP,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(RedisCreateProperties.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RedisLinkedServerCreateProperties.linkedRedisCacheId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RedisLinkedServerCreateProperties.linkedRedisCacheLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(RedisCreateParameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@clientName(RedisCacheAccessPolicyProperties.type,
  "TypePropertiesType",
  "csharp"
);
@@clientName(RedisOperationGroup.checkNameAvailability,
  "checkRedisNameAvailability",
  "csharp"
);
@@clientName(RedisLinkedServerWithProperties,
  "RedisLinkedServerWithProperty",
  "csharp"
);
@@clientName(AsyncOperationStatusOperationGroup.get,
  "getAsyncOperationStatus",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "RedisPrivateEndpointConnection",
  "csharp"
);

@@usage(RedisCreateParameters, Usage.input | Usage.output, "csharp");
@@usage(RedisCreateProperties, Usage.input | Usage.output, "csharp");
@@usage(RedisProperties, Usage.input | Usage.output, "csharp");

@@clientName(RedisResources.listBySubscription, "getAllRedis", "csharp");
@@clientName(RedisResources.listByRedisCache,
  "getPrivateLinkResourcesByRedisCache",
  "csharp"
);
@@alternateType(AsyncOperationStatusOperationGroup.get::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@clientName(RedisPatchSchedule.name, "defaultName", "csharp");
@@alternateType(RedisPatchSchedule.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@access(RedisLinkedServer, Access.public, "csharp");
@@usage(RedisLinkedServer, Usage.output, "csharp");

@@clientName(TlsVersion, "RedisTlsVersion", "csharp");

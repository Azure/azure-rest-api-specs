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

// Service definition is wrong
@@alternateType(Microsoft.Cache.RedisCommonPropertiesRedisConfiguration,
  RedisCommonPropertiesRedisConfigurationRecordString,
  "java"
);
/**
 * All Redis Settings. Few possible keys: rdb-backup-enabled,rdb-storage-connection-string,rdb-backup-frequency,maxmemory-delta, maxmemory-policy,notify-keyspace-events, aof-backup-enabled, aof-storage-connection-string-0, aof-storage-connection-string-1 etc.
 */
model RedisCommonPropertiesRedisConfigurationRecordString {
  ...Record<string>;

  /**
   * Specifies whether the RDB backup is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `rdb-backup-enabled`?: string;

  /**
   * Specifies the frequency for creating rdb backup in minutes. Valid values: (15, 30, 60, 360, 720, 1440)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `rdb-backup-frequency`?: string;

  /**
   * Specifies the maximum number of snapshots for rdb backup
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `rdb-backup-max-snapshot-count`?: string;

  /**
   * The storage account connection string for storing rdb file
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `rdb-storage-connection-string`?: string;

  /**
   * Specifies whether the aof backup is enabled
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `aof-backup-enabled`?: string;

  /**
   * First storage account connection string
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `aof-storage-connection-string-0`?: string;

  /**
   * Second storage account connection string
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `aof-storage-connection-string-1`?: string;

  /**
   * Value in megabytes reserved for fragmentation per shard
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `maxfragmentationmemory-reserved`?: string;

  /**
   * The eviction strategy used when your data won't fit within its memory limit.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `maxmemory-policy`?: string;

  /**
   * Value in megabytes reserved for non-cache usage per shard e.g. failover.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `maxmemory-reserved`?: string;

  /**
   * Value in megabytes reserved for non-cache usage per shard e.g. failover.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `maxmemory-delta`?: string;

  /**
   * The max clients config
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  @visibility(Lifecycle.Read)
  maxclients?: string;

  /**
   * The keyspace events which should be monitored.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `notify-keyspace-events`?: string;

  /**
   * Preferred auth method to communicate to storage account used for data archive, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  @visibility(Lifecycle.Read)
  `preferred-data-archive-auth-method`?: string;

  /**
   * Preferred auth method to communicate to storage account used for data persistence, specify SAS or ManagedIdentity, default value is SAS
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `preferred-data-persistence-auth-method`?: string;

  /**
   * Zonal Configuration
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  @visibility(Lifecycle.Read)
  `zonal-configuration`?: string;

  /**
   * Specifies whether the authentication is disabled. Setting this property is highly discouraged from security point of view; you should never disable authentication using this property!
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  authnotrequired?: string;

  /**
   * SubscriptionId of the storage account for persistence (aof/rdb) using ManagedIdentity.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `storage-subscription-id`?: string;

  /**
   * Specifies whether AAD based authentication has been enabled or disabled for the cache
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Following Redis.conf casing style"
  `aad-enabled`?: string;
}

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
// Fix Java SDK handwritten code
@@usage(RedisResource, Usage.input | Usage.output, "java");
@@usage(RedisFirewallRuleCreateParameters, Usage.input, "java");
@@alternateType(Azure.ResourceManager.CommonTypes.OperationStatusResult.percentComplete,
  float32,
  "java"
);

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
@@alternateType(RedisCacheAccessPolicyAssignmentProperties.objectId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(OperationStatus, "RedisOperationStatus", "csharp");
@@clientName(ProvisioningState, "RedisProvisioningState", "csharp");
@@clientName(PublicNetworkAccess, "RedisPublicNetworkAccess", "csharp");
@@clientName(RebootType, "RedisRebootType", "csharp");
@@clientName(TlsVersion, "RedisTlsVersion", "csharp");
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

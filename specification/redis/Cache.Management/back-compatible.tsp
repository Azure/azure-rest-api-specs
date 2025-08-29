import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

// Client decorators for operations (migrated from @operationId)

// Operations_List from main.tsp

// RedisResources operations
@@clientLocation(RedisResources.get, "Redis", "!csharp");

@@clientLocation(RedisResources.create, "Redis", "!csharp");

@@clientLocation(RedisResources.update, "Redis", "!csharp");

@@clientLocation(RedisResources.delete, "Redis", "!csharp");

@@clientLocation(RedisResources.listByResourceGroup, "Redis", "!csharp");

@@clientLocation(RedisResources.listBySubscription, "Redis", "!csharp");

@@clientLocation(RedisResources.listUpgradeNotifications, "Redis", "!csharp");

@@clientLocation(RedisResources.listKeys, "Redis", "!csharp");

@@clientLocation(RedisResources.regenerateKey, "Redis", "!csharp");

@@clientLocation(RedisResources.forceReboot, "Redis", "!csharp");

@@clientLocation(RedisResources.importData, "Redis", "!csharp");

@@clientLocation(RedisResources.exportData, "Redis", "!csharp");

@@clientLocation(RedisResources.flushCache, "Redis", "!csharp");

@@clientLocation(RedisResources.listByRedisCache,
  "PrivateLinkResources",
  "!csharp"
);

// RedisOperationGroup operations from routes.tsp
@@clientLocation(RedisOperationGroup.checkNameAvailability, "Redis", "!csharp");

@@clientLocation(AsyncOperationStatusOperationGroup.get,
  "AsyncOperationStatus",
  "!csharp"
);

// RedisCacheAccessPolicies operations
@@clientLocation(RedisCacheAccessPolicies.get, "AccessPolicy", "!csharp");

@@clientLocation(RedisCacheAccessPolicies.createUpdate,
  "AccessPolicy",
  "!csharp"
);

@@clientLocation(RedisCacheAccessPolicies.delete, "AccessPolicy", "!csharp");

@@clientLocation(RedisCacheAccessPolicies.list, "AccessPolicy", "!csharp");

// RedisCacheAccessPolicyAssignments operations
@@clientLocation(RedisCacheAccessPolicyAssignments.get,
  "AccessPolicyAssignment",
  "!csharp"
);

@@clientLocation(RedisCacheAccessPolicyAssignments.createUpdate,
  "AccessPolicyAssignment",
  "!csharp"
);

@@clientLocation(RedisCacheAccessPolicyAssignments.delete,
  "AccessPolicyAssignment",
  "!csharp"
);

@@clientLocation(RedisCacheAccessPolicyAssignments.list,
  "AccessPolicyAssignment",
  "!csharp"
);

// RedisFirewallRules operations
@@clientLocation(RedisFirewallRules.get, "FirewallRules", "!csharp");

@@clientLocation(RedisFirewallRules.createOrUpdate, "FirewallRules", "!csharp");

@@clientLocation(RedisFirewallRules.delete, "FirewallRules", "!csharp");

@@clientLocation(RedisFirewallRules.list, "FirewallRules", "!csharp");

// RedisPatchSchedules operations
@@clientLocation(RedisPatchSchedules.get, "PatchSchedules", "!csharp");

@@clientLocation(RedisPatchSchedules.createOrUpdate,
  "PatchSchedules",
  "!csharp"
);

@@clientLocation(RedisPatchSchedules.delete, "PatchSchedules", "!csharp");

@@clientLocation(RedisPatchSchedules.listByRedisResource,
  "PatchSchedules",
  "!csharp"
);

// Existing client decorators and properties
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisCreateParameters.properties);

@@clientName(RedisCommonPropertiesRedisConfiguration.`rdb-backup-enabled`,
  "rdbBackupEnabled"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`rdb-backup-frequency`,
  "rdbBackupFrequency"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`rdb-backup-max-snapshot-count`,
  "rdbBackupMaxSnapshotCount"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`rdb-storage-connection-string`,
  "rdbStorageConnectionString"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aof-backup-enabled`,
  "aofBackupEnabled"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aof-storage-connection-string-0`,
  "aofStorageConnectionString0"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aof-storage-connection-string-1`,
  "aofStorageConnectionString1"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxfragmentationmemory-reserved`,
  "maxfragmentationmemoryReserved"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-policy`,
  "maxmemoryPolicy"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-reserved`,
  "maxmemoryReserved"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`maxmemory-delta`,
  "maxmemoryDelta"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`notify-keyspace-events`,
  "notifyKeyspaceEvents"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`preferred-data-archive-auth-method`,
  "preferredDataArchiveAuthMethod"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`preferred-data-persistence-auth-method`,
  "preferredDataPersistenceAuthMethod"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`zonal-configuration`,
  "zonalConfiguration"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`storage-subscription-id`,
  "storageSubscriptionId"
);
@@clientName(RedisCommonPropertiesRedisConfiguration.`aad-enabled`,
  "aadEnabled"
);

#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisUpdateParameters.properties);

#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisLinkedServerCreateParameters.properties);

@@clientName(RedisResources.create::parameters.resource, "parameters");
@@clientName(RedisResources.update::parameters.properties, "parameters");
@@clientName(RedisResources.regenerateKey::parameters.body, "parameters");
@@clientName(RedisResources.forceReboot::parameters.body, "parameters");
@@clientName(RedisResources.importData::parameters.body, "parameters");
@@clientName(RedisResources.exportData::parameters.body, "parameters");
#suppress "deprecated" "FIXME: using flattening for SDK backwards compatibility"
@@flattenProperty(RedisResource.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(RedisFirewallRules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisFirewallRule.properties);

@@clientName(RedisPatchSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisPatchSchedule.properties);

@@clientName(LinkedServer.create::parameters.resource, "parameters");
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisLinkedServerWithProperties.properties);

@@clientName(RedisCacheAccessPolicies.createUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisCacheAccessPolicy.properties);

@@clientName(RedisCacheAccessPolicyAssignments.createUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FORNOW: using flattened 'properties' for SDK backwards compatibility"
@@flattenProperty(RedisCacheAccessPolicyAssignment.properties);
@@clientName(ScheduleEntries.scheduleEntries, "ScheduleEntries");
@@clientName(RedisOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);

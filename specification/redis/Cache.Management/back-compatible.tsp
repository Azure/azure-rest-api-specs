import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

// Client decorators for operations (migrated from @operationId)

// Operations_List from main.tsp
@@clientName(Operations.list, "List");

// RedisResources operations
@@clientLocation(RedisResources.get, "Redis", "!csharp");
@@clientName(RedisResources.get, "Get");

@@clientLocation(RedisResources.create, "Redis", "!csharp");
@@clientName(RedisResources.create, "Create");

@@clientLocation(RedisResources.update, "Redis", "!csharp");
@@clientName(RedisResources.update, "Update");

@@clientLocation(RedisResources.delete, "Redis", "!csharp");
@@clientName(RedisResources.delete, "Delete");

@@clientLocation(RedisResources.listByResourceGroup, "Redis", "!csharp");
@@clientName(RedisResources.listByResourceGroup, "ListByResourceGroup");

@@clientLocation(RedisResources.listBySubscription, "Redis", "!csharp");
@@clientName(RedisResources.listBySubscription, "ListBySubscription");

@@clientLocation(RedisResources.listUpgradeNotifications, "Redis", "!csharp");
@@clientName(RedisResources.listUpgradeNotifications,
  "ListUpgradeNotifications"
);

@@clientLocation(RedisResources.listKeys, "Redis", "!csharp");
@@clientName(RedisResources.listKeys, "ListKeys");

@@clientLocation(RedisResources.regenerateKey, "Redis", "!csharp");
@@clientName(RedisResources.regenerateKey, "RegenerateKey");

@@clientLocation(RedisResources.forceReboot, "Redis", "!csharp");
@@clientName(RedisResources.forceReboot, "ForceReboot");

@@clientLocation(RedisResources.importData, "Redis", "!csharp");
@@clientName(RedisResources.importData, "ImportData");

@@clientLocation(RedisResources.exportData, "Redis", "!csharp");
@@clientName(RedisResources.exportData, "ExportData");

@@clientLocation(RedisResources.flushCache, "Redis", "!csharp");
@@clientName(RedisResources.flushCache, "FlushCache");

@@clientLocation(RedisResources.listByRedisCache,
  "PrivateLinkResources",
  "!csharp"
);
@@clientName(RedisResources.listByRedisCache, "ListByRedisCache");

// RedisOperationGroup operations from routes.tsp
@@clientLocation(RedisOperationGroup.checkNameAvailability, "Redis", "!csharp");
@@clientName(RedisOperationGroup.checkNameAvailability,
  "CheckNameAvailability"
);

@@clientLocation(AsyncOperationStatusOperationGroup.get,
  "AsyncOperationStatus",
  "!csharp"
);
@@clientName(AsyncOperationStatusOperationGroup.get, "Get");

// RedisCacheAccessPolicies operations
@@clientLocation(RedisCacheAccessPolicies.get, "AccessPolicy", "!csharp");
@@clientName(RedisCacheAccessPolicies.get, "Get");

@@clientLocation(RedisCacheAccessPolicies.createUpdate,
  "AccessPolicy",
  "!csharp"
);
@@clientName(RedisCacheAccessPolicies.createUpdate, "CreateUpdate");

@@clientLocation(RedisCacheAccessPolicies.delete, "AccessPolicy", "!csharp");
@@clientName(RedisCacheAccessPolicies.delete, "Delete");

@@clientLocation(RedisCacheAccessPolicies.list, "AccessPolicy", "!csharp");
@@clientName(RedisCacheAccessPolicies.list, "List");

// RedisCacheAccessPolicyAssignments operations
@@clientLocation(RedisCacheAccessPolicyAssignments.get,
  "AccessPolicyAssignment",
  "!csharp"
);
@@clientName(RedisCacheAccessPolicyAssignments.get, "Get");

@@clientLocation(RedisCacheAccessPolicyAssignments.createUpdate,
  "AccessPolicyAssignment",
  "!csharp"
);
@@clientName(RedisCacheAccessPolicyAssignments.createUpdate, "CreateUpdate");

@@clientLocation(RedisCacheAccessPolicyAssignments.delete,
  "AccessPolicyAssignment",
  "!csharp"
);
@@clientName(RedisCacheAccessPolicyAssignments.delete, "Delete");

@@clientLocation(RedisCacheAccessPolicyAssignments.list,
  "AccessPolicyAssignment",
  "!csharp"
);
@@clientName(RedisCacheAccessPolicyAssignments.list, "List");

// RedisFirewallRules operations
@@clientLocation(RedisFirewallRules.get, "FirewallRules", "!csharp");
@@clientName(RedisFirewallRules.get, "Get");

@@clientLocation(RedisFirewallRules.createOrUpdate, "FirewallRules", "!csharp");
@@clientName(RedisFirewallRules.createOrUpdate, "CreateOrUpdate");

@@clientLocation(RedisFirewallRules.delete, "FirewallRules", "!csharp");
@@clientName(RedisFirewallRules.delete, "Delete");

@@clientLocation(RedisFirewallRules.list, "FirewallRules", "!csharp");
@@clientName(RedisFirewallRules.list, "List");

// RedisPatchSchedules operations
@@clientLocation(RedisPatchSchedules.get, "PatchSchedules", "!csharp");
@@clientName(RedisPatchSchedules.get, "Get");

@@clientLocation(RedisPatchSchedules.createOrUpdate,
  "PatchSchedules",
  "!csharp"
);
@@clientName(RedisPatchSchedules.createOrUpdate, "CreateOrUpdate");

@@clientLocation(RedisPatchSchedules.delete, "PatchSchedules", "!csharp");
@@clientName(RedisPatchSchedules.delete, "Delete");

@@clientLocation(RedisPatchSchedules.listByRedisResource,
  "PatchSchedules",
  "!csharp"
);
@@clientName(RedisPatchSchedules.listByRedisResource, "ListByRedisResource");

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

@@clientName(RedisResources.create::parameters.properties, "parameters");
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

@@clientName(LinkedServer.create::parameters.properties, "parameters");
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

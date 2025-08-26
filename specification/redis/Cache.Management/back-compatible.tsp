import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

// Client decorators for operations (migrated from @operationId)

// Operations_List from main.tsp
@@clientName(Operations.list, "List");

// RedisResources operations
@@clientLocation(RedisResources.get, "Redis");
@@clientName(RedisResources.get, "Get");

@@clientLocation(RedisResources.create, "Redis");
@@clientName(RedisResources.create, "Create");

@@clientLocation(RedisResources.update, "Redis");
@@clientName(RedisResources.update, "Update");

@@clientLocation(RedisResources.delete, "Redis");
@@clientName(RedisResources.delete, "Delete");

@@clientLocation(RedisResources.listByResourceGroup, "Redis");
@@clientName(RedisResources.listByResourceGroup, "ListByResourceGroup");

@@clientLocation(RedisResources.listBySubscription, "Redis");
@@clientName(RedisResources.listBySubscription, "ListBySubscription");

@@clientLocation(RedisResources.listUpgradeNotifications, "Redis");
@@clientName(RedisResources.listUpgradeNotifications,
  "ListUpgradeNotifications"
);

@@clientLocation(RedisResources.listKeys, "Redis");
@@clientName(RedisResources.listKeys, "ListKeys");

@@clientLocation(RedisResources.regenerateKey, "Redis");
@@clientName(RedisResources.regenerateKey, "RegenerateKey");

@@clientLocation(RedisResources.forceReboot, "Redis");
@@clientName(RedisResources.forceReboot, "ForceReboot");

@@clientLocation(RedisResources.importData, "Redis");
@@clientName(RedisResources.importData, "ImportData");

@@clientLocation(RedisResources.exportData, "Redis");
@@clientName(RedisResources.exportData, "ExportData");

@@clientLocation(RedisResources.flushCache, "Redis");
@@clientName(RedisResources.flushCache, "FlushCache");

@@clientLocation(RedisResources.listByRedisCache, "PrivateLinkResources");
@@clientName(RedisResources.listByRedisCache, "ListByRedisCache");

// RedisOperationGroup operations from routes.tsp
@@clientLocation(RedisOperationGroup.checkNameAvailability, "Redis");
@@clientName(RedisOperationGroup.checkNameAvailability,
  "CheckNameAvailability"
);

@@clientLocation(AsyncOperationStatusOperationGroup.get,
  "AsyncOperationStatus"
);
@@clientName(AsyncOperationStatusOperationGroup.get, "Get");

// RedisCacheAccessPolicies operations
@@clientLocation(RedisCacheAccessPolicies.get, "AccessPolicy");
@@clientName(RedisCacheAccessPolicies.get, "Get");

@@clientLocation(RedisCacheAccessPolicies.createUpdate, "AccessPolicy");
@@clientName(RedisCacheAccessPolicies.createUpdate, "CreateUpdate");

@@clientLocation(RedisCacheAccessPolicies.delete, "AccessPolicy");
@@clientName(RedisCacheAccessPolicies.delete, "Delete");

@@clientLocation(RedisCacheAccessPolicies.list, "AccessPolicy");
@@clientName(RedisCacheAccessPolicies.list, "List");

// RedisCacheAccessPolicyAssignments operations
@@clientLocation(RedisCacheAccessPolicyAssignments.get,
  "AccessPolicyAssignment"
);
@@clientName(RedisCacheAccessPolicyAssignments.get, "Get");

@@clientLocation(RedisCacheAccessPolicyAssignments.createUpdate,
  "AccessPolicyAssignment"
);
@@clientName(RedisCacheAccessPolicyAssignments.createUpdate, "CreateUpdate");

@@clientLocation(RedisCacheAccessPolicyAssignments.delete,
  "AccessPolicyAssignment"
);
@@clientName(RedisCacheAccessPolicyAssignments.delete, "Delete");

@@clientLocation(RedisCacheAccessPolicyAssignments.list,
  "AccessPolicyAssignment"
);
@@clientName(RedisCacheAccessPolicyAssignments.list, "List");

// RedisFirewallRules operations
@@clientLocation(RedisFirewallRules.get, "FirewallRules");
@@clientName(RedisFirewallRules.get, "Get");

@@clientLocation(RedisFirewallRules.createOrUpdate, "FirewallRules");
@@clientName(RedisFirewallRules.createOrUpdate, "CreateOrUpdate");

@@clientLocation(RedisFirewallRules.delete, "FirewallRules");
@@clientName(RedisFirewallRules.delete, "Delete");

@@clientLocation(RedisFirewallRules.list, "FirewallRules");
@@clientName(RedisFirewallRules.list, "List");

// RedisPatchSchedules operations
@@clientLocation(RedisPatchSchedules.get, "PatchSchedules");
@@clientName(RedisPatchSchedules.get, "Get");

@@clientLocation(RedisPatchSchedules.createOrUpdate, "PatchSchedules");
@@clientName(RedisPatchSchedules.createOrUpdate, "CreateOrUpdate");

@@clientLocation(RedisPatchSchedules.delete, "PatchSchedules");
@@clientName(RedisPatchSchedules.delete, "Delete");

@@clientLocation(RedisPatchSchedules.listByRedisResource, "PatchSchedules");
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

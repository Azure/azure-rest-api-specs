import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisLinkedServerCreateParameters.properties);

@@clientName(RedisResources.create::parameters.resource, "parameters");
@@clientName(RedisResources.update::parameters.properties, "parameters");
@@clientName(RedisResources.regenerateKey::parameters.body, "parameters");
@@clientName(RedisResources.forceReboot::parameters.body, "parameters");
@@clientName(RedisResources.importData::parameters.body, "parameters");
@@clientName(RedisResources.exportData::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisResource.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(RedisFirewallRules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisFirewallRule.properties);

@@clientName(RedisPatchSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisPatchSchedule.properties);

@@clientName(LinkedServer.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisLinkedServerWithProperties.properties);

@@clientName(RedisCacheAccessPolicies.createUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisCacheAccessPolicy.properties);

@@clientName(RedisCacheAccessPolicyAssignments.createUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RedisCacheAccessPolicyAssignment.properties);
@@clientName(ScheduleEntries.scheduleEntries, "ScheduleEntries");

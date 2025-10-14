## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationProperties.properties.analyzedWorkload.$ref__added` | added | `#/definitions/ObjectRecommendationPropertiesAnalyzedWorkload` |
| `definitions.ObjectRecommendationProperties.properties.implementationDetails.$ref__added` | added | `#/definitions/ObjectRecommendationPropertiesImplementationDetails` |
| `definitions.UserAssignedIdentity.properties.userAssignedIdentities.$ref__deleted` | deleted | `#/definitions/UserAssignedIdentityMap` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/LocationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/LocationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/LocationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/LocationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].name__added` | added | `locationName` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].name__added` | added | `locationName` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].name__added` | added | `locationName` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].name__added` | added | `locationName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].name__added` | added | `serverName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdministratorMicrosoftEntraList.required__added` | added | `["value"]` |
| `definitions.AdvancedThreatProtectionSettingsList.required__added` | added | `["value"]` |
| `definitions.BackupAutomaticAndOnDemandList.required__added` | added | `["value"]` |
| `definitions.BackupsLongTermRetentionOperation.required__deleted` | deleted | `["id","name"]` |
| `definitions.CapabilityList.required__added` | added | `["value"]` |
| `definitions.CapturedLogList.required__added` | added | `["value"]` |
| `definitions.ConfigurationList.required__added` | added | `["value"]` |
| `definitions.DatabaseList.required__added` | added | `["value"]` |
| `definitions.FirewallRuleList.required__added` | added | `["value"]` |
| `definitions.LtrServerBackupOperationList.required__added` | added | `["value"]` |
| `definitions.MigrationList.required__added` | added | `["value"]` |
| `definitions.ObjectRecommendationList.required__added` | added | `["value"]` |
| `definitions.OperationList.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionList.required__added` | added | `["value"]` |
| `definitions.PrivateLinkResourceList.required__added` | added | `["value"]` |
| `definitions.QuotaUsageList.required__added` | added | `["value"]` |
| `definitions.ServerList.required__added` | added | `["value"]` |
| `definitions.TuningOptionsList.required__added` | added | `["value"]` |
| `definitions.VirtualEndpointsList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationProperties.properties.analyzedWorkload.type__deleted` | deleted | `object` |
| `definitions.ObjectRecommendationProperties.properties.implementationDetails.type__deleted` | deleted | `object` |
| `definitions.Operation.properties.properties.additionalProperties.type__deleted` | deleted | `object` |
| `definitions.UserAssignedIdentity.properties.userAssignedIdentities.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].type__added` | added | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].minLength__added` | added | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].minLength__added` | added | `3` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/capabilities'].get.parameters[0].pattern__added` | added | `^[-\\w\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[0].pattern__added` | added | `^[-\\w\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[0].pattern__added` | added | `^[-\\w\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/resourceType/flexibleServers/usages'].get.parameters[0].pattern__added` | added | `^[-\\w\\._]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings/{threatProtectionName}'].get.parameters[2].pattern__deleted` | deleted | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings/{threatProtectionName}'].put.parameters[2].pattern__deleted` | deleted | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/capabilities'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/checkMigrationNameAvailability'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/logFiles'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/migrations'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/tuningOptions/{tuningOption}/recommendations'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints'].get.parameters[0].maxLength__added` | added | `63` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupStoreDetails.properties.sasUriList.items.description__deleted` | deleted | `SAS URI of Azure Storage Account Container.` |
| `definitions.VirtualEndpointResourceProperties.properties.members.items.description__deleted` | deleted | `Server that one of the virtual endpoints can refer to.` |
| `definitions.VirtualEndpointResourceProperties.properties.virtualEndpoints.items.description__deleted` | deleted | `Virtual endpoints for a server.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings/{threatProtectionName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings/{threatProtectionName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].patch.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].patch.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].delete.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].patch.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].patch.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].put.responses.202.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminCredentials.properties.sourceServerPassword.format__added` | added | `password` |
| `definitions.AdminCredentials.properties.targetServerPassword.format__added` | added | `password` |
| `definitions.AdminCredentialsForPatch.properties.sourceServerPassword.format__added` | added | `password` |
| `definitions.AdminCredentialsForPatch.properties.targetServerPassword.format__added` | added | `password` |
| `definitions.Network.properties.delegatedSubnetResourceId.format__added` | added | `arm-id` |
| `definitions.Network.properties.privateDnsZoneArmResourceId.format__added` | added | `arm-id` |
| `definitions.ServerProperties.properties.sourceServerResourceId.format__added` | added | `arm-id` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/restart'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/start'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/stop'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `UserAssignedIdentityMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityMap__deleted` | deleted | `{"type":"object","description":"Map of user assigned managed identities.","additionalProperties":{"$...` |

### Changes for `CapabilityBase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityBase__added` | added | `{"type":"object","description":"Base object for representing capability","properties":{"status":{"ty...` |

### Changes for `ObjectRecommendationPropertiesAnalyzedWorkload`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationPropertiesAnalyzedWorkload__added` | added | `{"type":"object","description":"Workload information for the recommended action.","properties":{"sta...` |

### Changes for `ObjectRecommendationPropertiesImplementationDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationPropertiesImplementationDetails__added` | added | `{"type":"object","description":"Implementation details for the recommended action.","properties":{"m...` |

### Changes for `PrivateLinkResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource__added` | added | `{"type":"object","description":"A private link resource.","properties":{"properties":{"$ref":"../../...` |

### Changes for `x-ms-external`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminCredentials.properties.sourceServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentials.properties.targetServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.sourceServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.targetServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParameters.properties.adminCredentials['x-ms-external__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParametersForPatch.properties.adminCredentials['x-ms-external__deleted']` | deleted | `true` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupForPatch.properties.geoRedundantBackup['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataEncryption.properties.geoBackupEncryptionKeyStatus['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataEncryption.properties.primaryEncryptionKeyStatus['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DbServerMetadata.properties.location['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.ServerPropertiesForPatch.properties.administratorLogin['x-ms-mutability__deleted']` | deleted | `["read"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupForPatch.properties.geoRedundantBackup.readOnly__added` | added | `true` |
| `definitions.DataEncryption.properties.geoBackupEncryptionKeyStatus.readOnly__added` | added | `true` |
| `definitions.DataEncryption.properties.primaryEncryptionKeyStatus.readOnly__added` | added | `true` |
| `definitions.ObjectRecommendation.properties.properties.readOnly__added` | added | `true` |
| `definitions.ObjectRecommendationDetails.readOnly__deleted` | deleted | `true` |
| `definitions.ObjectRecommendationProperties.properties.details.readOnly__added` | added | `true` |
| `definitions.ObjectRecommendationProperties.readOnly__deleted` | deleted | `true` |
| `definitions.ServerPropertiesForPatch.properties.administratorLogin.readOnly__added` | added | `true` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackupStoreDetails.properties.sasUriList.items['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParameters.properties.adminCredentials['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParametersForPatch.properties.adminCredentials['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `x-ms-visibility`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendation.properties.kind['x-ms-visibility__deleted']` | deleted | `internal` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationProperties.properties.analyzedWorkload.properties__deleted` | deleted | `{"startTime":{"type":"string","format":"date-time","description":"Start time (UTC) of the workload a...` |
| `definitions.ObjectRecommendationProperties.properties.implementationDetails.properties__deleted` | deleted | `{"method":{"type":"string","description":"Method of implementation for recommended action."},"script...` |
| `definitions.VirtualEndpoint.properties__added` | added | `{"properties":{"$ref":"#/definitions/VirtualEndpointResourceProperties","description":"Properties of...` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation.properties.properties['x-ms-client-flatten__deleted']` | deleted | `false` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServerProperties.properties.authConfig.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.backup.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.cluster.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.dataEncryption.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.highAvailability.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.maintenanceWindow.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.network.default__deleted` | deleted | `null` |
| `definitions.ServerProperties.properties.storage.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.authConfig.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.backup.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.cluster.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.dataEncryption.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.highAvailability.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.maintenanceWindow.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.network.default__deleted` | deleted | `null` |
| `definitions.ServerPropertiesForPatch.properties.storage.default__deleted` | deleted | `null` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentity.properties.userAssignedIdentities.additionalProperties__added` | added | `{"$ref":"#/definitions/UserIdentity"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Capability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.DataEncryption.properties.geoBackupEncryptionKeyStatus.description` | `Status of key used by a server configured with data encryption based on customer managed key, to encrypt the geographically redundant storage associated to the server when it is configured to support geographically redundant backups.` | `Status of key used by a server configured with data encryption based on customer managed key, to encrypt the primary storage associated to the server.` |
| `definitions.FastProvisioningEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.HighAvailabilityForPatch.properties.mode.description` | `High availability mode for a server.` | `Modes of high availability supported for this compute.` |
| `definitions.Network.properties.publicNetworkAccess.description` | `Indicates if public network access is enabled or not. This is only supported for servers that are not integrated into a virtual network which is owned and provided by customer when server is deployed.` | `Indicates if public network access is enabled or not.` |
| `definitions.PrivateLinkResourceList.properties.value.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |
| `definitions.ServerEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.ServerSkuCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.ServerVersionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageMbCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageTierCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.VirtualEndpoint.allOf[0].$ref` | `#/definitions/VirtualEndpointResourceForPatch` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].$ref` | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].$ref` | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].$ref` | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` | `../../../../../common-types/resource-management/v6/privatelinks.json#/parameters/PrivateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources/{groupName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.responses.200.schema.$ref` | `./Servers.json#/definitions/ServerList` | `#/definitions/ServerList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.responses.202.headers.Location.description` | `URL to retrieve the final result after operation completes.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.` | `A link to the status monitor` |


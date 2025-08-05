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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/ServerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].$ref__deleted` | deleted | `../../../types/common-types.json#/parameters/PrivateEndpointConnectionNameParameter` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].name__added` | added | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].name__added` | added | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].name__added` | added | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].name__added` | added | `privateEndpointConnectionName` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].in__added` | added | `path` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].required__added` | added | `true` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].type__added` | added | `string` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]*\\.[a-fA-F0-9\\-]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]*\\.[a-fA-F0-9\\-]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[1].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]*\\.[a-fA-F0-9\\-]+$` |
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

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/advancedThreatProtectionSettings/{threatProtectionName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/backups/{backupName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].patch['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/databases/{databaseName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/firewallRules/{firewallRuleName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `200`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}'].patch.responses.200__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Server"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].patch.responses.200__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/Configuration"}}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.responses.200.headers__deleted` | deleted | `{"x-ms-request-id":{"type":"string","description":"A unique ID for the current operation, service ge...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrPreBackup'].post.responses.default.headers__deleted` | deleted | `{"x-ms-error-code":{"type":"string","description":"ErrorCode string in the event of a failure."},"x-...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.responses.200.headers__deleted` | deleted | `{"x-ms-request-id":{"type":"string","description":"A unique ID for the current operation, service ge...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.responses.202.headers__deleted` | deleted | `{"x-ms-request-id":{"type":"string","description":"A unique ID for the current operation, service ge...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/startLtrBackup'].post.responses.default.headers__deleted` | deleted | `{"x-ms-error-code":{"type":"string","description":"ErrorCode string in the event of a failure."},"x-...` |

### Changes for `AdministratorMicrosoftEntraAdd`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdministratorMicrosoftEntraAdd__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AdministratorMicrosoftEntraProper...` |

### Changes for `AdministratorMicrosoftEntraPropertiesForAdd`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdministratorMicrosoftEntraPropertiesForAdd__deleted` | deleted | `{"type":"object","properties":{"principalType":{"type":"string","enum":["Unknown","User","Group","Se...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"display":{"$ref":"#/definit...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string","readOnly":true},"resource":{"type":"stri...` |

### Changes for `OperationList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `UserAssignedIdentityMap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityMap__deleted` | deleted | `{"type":"object","additionalProperties":{"$ref":"#/definitions/UserIdentity"}}` |

### Changes for `Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", { azureAsyncOperation: string, retryAfter: int32 }>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", { azureAsyncOperation: string, retryAfter: int32 }>__added']` | added | `{"type":"object"}` |

### Changes for `Azure.ResourceManager.ArmResponse<BackupsLongTermRetentionResponse>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<BackupsLongTermRetentionResponse>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/BackupsLongTermRetentionResponse"}},"re...` |

### Changes for `CapabilityBase`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityBase__added` | added | `{"type":"object","properties":{"status":{"type":"string","enum":["Visible","Available","Default","Di...` |

### Changes for `ObjectRecommendationPropertiesAnalyzedWorkload`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationPropertiesAnalyzedWorkload__added` | added | `{"type":"object","properties":{"startTime":{"type":"string","format":"date-time"},"endTime":{"type":...` |

### Changes for `ObjectRecommendationPropertiesImplementationDetails`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationPropertiesImplementationDetails__added` | added | `{"type":"object","properties":{"method":{"type":"string"},"script":{"type":"string"}}}` |

### Changes for `PrivateEndpointConnection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateEndpointConnection__added` | added | `{"type":"object","properties":{"properties":{"$ref":"../../../../../common-types/resource-management...` |

### Changes for `PrivateLinkResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResource__added` | added | `{"type":"object","properties":{"properties":{"$ref":"../../../../../common-types/resource-management...` |

### Changes for `x-ms-external`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminCredentials.properties.sourceServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentials.properties.targetServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.sourceServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.targetServerPassword['x-ms-external__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParameters.properties.adminCredentials['x-ms-external__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParametersForPatch.properties.adminCredentials['x-ms-external__deleted']` | deleted | `true` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminCredentials.properties.sourceServerPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.AdminCredentials.properties.targetServerPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.sourceServerPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.AdminCredentialsForPatch.properties.targetServerPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.BackupStoreDetails.properties.sasUriList.items['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParameters.properties.adminCredentials['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.MigrationSecretParametersForPatch.properties.adminCredentials['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdvancedThreatProtectionSettingsList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.CapabilityList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.DataEncryption.properties.geoBackupEncryptionKeyStatus.readOnly__added` | added | `true` |
| `definitions.DataEncryption.properties.primaryEncryptionKeyStatus.readOnly__added` | added | `true` |
| `definitions.MigrationList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ObjectRecommendation.properties.properties.readOnly__added` | added | `true` |
| `definitions.ObjectRecommendationDetails.readOnly__deleted` | deleted | `true` |
| `definitions.ObjectRecommendationProperties.properties.details.readOnly__added` | added | `true` |
| `definitions.ObjectRecommendationProperties.readOnly__deleted` | deleted | `true` |
| `definitions.PrivateEndpointConnectionList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.PrivateLinkResourceList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.QuotaUsageList.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AuthConfig.properties.passwordAuth.default__deleted` | deleted | `Enabled` |
| `definitions.Backup.properties.geoRedundantBackup.default__deleted` | deleted | `Disabled` |
| `definitions.Cluster.properties.clusterSize.default__deleted` | deleted | `0` |
| `definitions.HighAvailability.properties.mode.default__deleted` | deleted | `Disabled` |
| `definitions.MaintenanceWindow.properties.dayOfWeek.default__deleted` | deleted | `0` |
| `definitions.MaintenanceWindow.properties.startHour.default__deleted` | deleted | `0` |
| `definitions.MaintenanceWindow.properties.startMinute.default__deleted` | deleted | `0` |
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

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CapabilityList.properties.value['x-ms-identifiers__deleted']` | deleted | `["name"]` |
| `definitions.ObjectRecommendationList.properties.value['x-ms-identifiers__deleted']` | deleted | `["name"]` |
| `definitions.QuotaUsageList.properties.value['x-ms-identifiers__deleted']` | deleted | `["name"]` |
| `definitions.TuningOptionsList.properties.value['x-ms-identifiers__deleted']` | deleted | `["name"]` |

### Changes for `x-ms-mutability`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataEncryption.properties.geoBackupEncryptionKeyStatus['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DataEncryption.properties.primaryEncryptionKeyStatus['x-ms-mutability__deleted']` | deleted | `["read"]` |
| `definitions.DbServerMetadata.properties.location['x-ms-mutability__deleted']` | deleted | `["read"]` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LtrBackupOperationResponseProperties.properties.percentComplete.minimum__deleted` | deleted | `0` |

### Changes for `maxItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MigrationProperties.properties.dbsToMigrate.maxItems__deleted` | deleted | `50` |
| `definitions.MigrationPropertiesForPatch.properties.dbsToMigrate.maxItems__deleted` | deleted | `50` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Network.properties.delegatedSubnetResourceId.format__added` | added | `arm-id` |
| `definitions.Network.properties.privateDnsZoneArmResourceId.format__added` | added | `arm-id` |
| `definitions.ServerProperties.properties.sourceServerResourceId.format__added` | added | `arm-id` |

### Changes for `x-ms-visibility`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendation.properties.kind['x-ms-visibility__deleted']` | deleted | `internal` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ObjectRecommendationProperties.properties.analyzedWorkload.properties__deleted` | deleted | `{"startTime":{"type":"string","format":"date-time","description":"Start time (UTC) of the workload a...` |
| `definitions.ObjectRecommendationProperties.properties.implementationDetails.properties__deleted` | deleted | `{"method":{"type":"string","description":"Method of implementation for recommended action."},"script...` |
| `definitions.PrivateDnsZoneSuffix.properties__added` | added | `{"value":{"type":"string","readOnly":true}}` |
| `definitions.TuningOptions.properties__added` | added | `{"properties":{"type":"object","x-ms-client-flatten":true}}` |
| `definitions.VirtualEndpoint.properties__added` | added | `{"properties":{"type":"object","x-ms-client-flatten":true}}` |

### Changes for `additionalProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentity.properties.userAssignedIdentities.additionalProperties__added` | added | `{"$ref":"#/definitions/UserIdentity"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Capability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.FastProvisioningEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.PrivateDnsZoneSuffix.type` | `string` | `object` |
| `definitions.PrivateEndpointConnectionList.properties.value.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `definitions.PrivateLinkResourceList.properties.value.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |
| `definitions.ServerEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.ServerProperties.properties.privateEndpointConnections.items.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `definitions.ServerSkuCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.ServerVersionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageEditionCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageMbCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.StorageTierCapability.allOf[0].$ref` | `../../../types/common-types.json#/definitions/CapabilityBase` | `#/definitions/CapabilityBase` |
| `definitions.VirtualEndpoint.allOf[0].$ref` | `#/definitions/VirtualEndpointResourceForPatch` | `../../../../../common-types/resource-management/v6/types.json#/definitions/ProxyResource` |
| `paths['/providers/microsoft.DBforPostgreSQL/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationList` | `../../../../../common-types/resource-management/v6/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/checkNameAvailability'].post.parameters[0].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkNameAvailability'].post.parameters[1].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DBforPostgreSQL/locations/{locationName}/checkVirtualNetworkSubnetUsage'].post.parameters[1].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/administrators/{objectId}'].put.parameters[3].schema.$ref` | `#/definitions/AdministratorMicrosoftEntraAdd` | `#/definitions/AdministratorMicrosoftEntra` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/configurations/{configurationName}'].put.parameters[3].schema.$ref` | `#/definitions/ConfigurationForUpdate` | `#/definitions/Configuration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations/{backupName}'].get.parameters[1].maxLength` | `128` | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations/{backupName}'].get.parameters[1].minLength` | `1` | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations/{backupName}'].get.parameters[1].name` | `backupName` | `serverName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/ltrBackupOperations/{backupName}'].get.parameters[1].pattern` | `^[-\\w\\._]+$` | `^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[2].schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateEndpointConnection` | `#/definitions/PrivateEndpointConnection` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/privateLinkResources/{groupName}'].get.responses.200.schema.$ref` | `../../../../../common-types/resource-management/v6/privatelinks.json#/definitions/PrivateLinkResource` | `#/definitions/PrivateLinkResource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/replicas'].get.responses.200.schema.$ref` | `./Servers.json#/definitions/ServerList` | `#/definitions/ServerList` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DBforPostgreSQL/flexibleServers/{serverName}/virtualendpoints/{virtualEndpointName}'].patch['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |


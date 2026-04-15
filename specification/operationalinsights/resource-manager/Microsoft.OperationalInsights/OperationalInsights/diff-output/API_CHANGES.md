## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/deletedWorkspaces'].get.tags__deleted` | deleted | `["DeletedWorkspaces"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.tags__deleted` | deleted | `["asyncOperations"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/queryPacks'].get.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/deletedWorkspaces'].get.tags__deleted` | deleted | `["DeletedWorkspaces"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.tags__deleted` | deleted | `["Workspaces"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks'].get.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].delete.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].get.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].patch.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].put.tags__added` | added | `["LogAnalyticsQueryPacks"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries'].get.tags__added` | added | `["LogAnalyticsQueryPackQueries"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].delete.tags__added` | added | `["LogAnalyticsQueryPackQueries"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].get.tags__added` | added | `["LogAnalyticsQueryPackQueries"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].patch.tags__added` | added | `["LogAnalyticsQueryPackQueries"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].put.tags__added` | added | `["LogAnalyticsQueryPackQueries"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/search'].post.tags__added` | added | `["LogAnalyticsQueryPacks"]` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].name__added` | added | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].name__added` | added | `tableName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].name__added` | added | `workspaceName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterListResult.required__added` | added | `["value"]` |
| `definitions.DataSourceListResult.required__added` | added | `["value"]` |
| `definitions.SummaryLogsListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.properties.type__deleted` | deleted | `object` |
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.related.type__deleted` | deleted | `object` |
| `definitions.LogAnalyticsQueryPackQuerySearchProperties.properties.related.type__deleted` | deleted | `object` |
| `definitions.OperationStatus.properties.error.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].type__added` | added | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.related.$ref__added` | added | `#/definitions/LogAnalyticsQueryPackQueryPropertiesRelated` |
| `definitions.LogAnalyticsQueryPackQuerySearchProperties.properties.related.$ref__added` | added | `#/definitions/LogAnalyticsQueryPackQuerySearchPropertiesRelated` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.parameters[0].$ref__added` | added | `../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/TableNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].$ref__deleted` | deleted | `../../common/v1/types.json#/parameters/WorkspaceNameParameter` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/locations/{location}/operationStatuses/{asyncOperationId}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataSources'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataSources/{dataSourceName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataSources/{dataSourceName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataSources/{dataSourceName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/gateways/{gatewayId}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks/{intelligencePackName}/disable'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks/{intelligencePackName}/enable'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/operations/{purgeId}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches/{savedSearchId}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches/{savedSearchId}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches/{savedSearchId}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs/{storageInsightName}'].delete.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs/{storageInsightName}'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs/{storageInsightName}'].put.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.responses.default__added` | added | `{"description":"ignore","schema":{"$ref":"../../../common-types/resource-management/v5/types.json#/d...` |

### Changes for `WorkspacesSubscriptionList`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/queryPacks'].get['x-ms-examples'].WorkspacesSubscriptionList__added` | added | `{"$ref":"./examples/WorkspacesSubscriptionListForQueryPacks.json"}` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.parameters[0].minLength__deleted` | deleted | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].minLength__added` | added | `4` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].minLength__added` | added | `4` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].maxLength__added` | added | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].maxLength__added` | added | `63` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[1].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/availableServiceTiers'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].delete.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedStorageAccounts/{dataSourceType}'].put.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/managementGroups'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/regenerateSharedKey'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/savedSearches'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/schema'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/sharedKeys'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/storageInsightConfigs'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.parameters[1].pattern__added` | added | `^[A-Za-z0-9-_]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get.parameters[0].pattern__added` | added | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |

### Changes for `azure-asyncoperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].patch.responses.202.headers['azure-asyncoperation__deleted']` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.responses.202.headers['azure-asyncoperation__deleted']` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.responses.202.headers['azure-asyncoperation__deleted']` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.responses.202.headers['azure-asyncoperation__deleted']` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.responses.202.headers['azure-asyncoperation__deleted']` | deleted | `{"type":"string"}` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].patch.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","description":"A link to the status monitor"}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].patch.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}/reconcile'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/linkedServices/{linkedServiceName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/purge'].post.responses.202.headers__deleted` | deleted | `{"x-ms-status-location":{"type":"string","description":"The location from which to request the opera...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `x-ms-examples`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces'].get['x-ms-examples__deleted']` | deleted | `{"WorkspacesGet":{"$ref":"./examples/WorkspacesListByResourceGroup.json"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put['x-ms-examples__deleted']` | deleted | `{"TablesUpsert":{"$ref":"./examples/TablesUpsert.json"}}` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/usages'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `404`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].delete.responses.404__deleted` | deleted | `{"description":"ignore"}` |

### Changes for `x-ms-odata`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataSources'].get['x-ms-odata__deleted']` | deleted | `#/definitions/DataSourceFilter` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResultStatistics.properties.progress.format__added` | added | `float` |
| `definitions.ResultStatistics.properties.scannedGb.format__added` | added | `float` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].delete.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.200.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.201.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/retrybin'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/retrybin'].post['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SummaryLogs` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/start'].post['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SummaryLogs` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Table` |

### Changes for `Location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/start'].post.responses.202.headers.Location__deleted` | deleted | `{"type":"string","description":"Operation Status Location URI"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.responses.202.headers.Location__deleted` | deleted | `{"type":"string"}` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `DataSourceFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataSourceFilter__deleted` | deleted | `{"type":"object","description":"DataSource filter. Right now, only filter by kind is supported.","pr...` |

### Changes for `Object`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Object__deleted` | deleted | `{"type":"object","description":"JSON object","properties":{}}` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","description":"Supported operation of OperationalInsights resource provider.","prop...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `WorkspaceReplicationPatProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.WorkspaceReplicationPatProperties__deleted` | deleted | `{"type":"object","description":"Workspace replication properties.","properties":{"location":{"type":...` |

### Changes for `keyVaultProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.keyVaultProperties__deleted` | deleted | `{"type":"object","description":"The key vault properties.","properties":{"keyVaultUri":{"type":"stri...` |

### Changes for `Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", { azureAsyncOperation: TypeSpec.Rest.ResourceLocation, location: string, retryAfter: int32 }>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmAcceptedLroResponse<"Resource operation accepted.", { azureAsyncOperation: TypeSpec.Rest.ResourceLocation, location: string, retryAfter: int32 }>__added']` | added | `{"type":"object","description":"Resource operation accepted."}` |

### Changes for `KeyVaultProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.KeyVaultProperties__added` | added | `{"type":"object","description":"The key vault properties.","properties":{"keyVaultUri":{"type":"stri...` |

### Changes for `LogAnalyticsQueryPackQueryPropertiesRelated`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogAnalyticsQueryPackQueryPropertiesRelated__added` | added | `{"type":"object","description":"The related metadata items for the function.","properties":{"categor...` |

### Changes for `LogAnalyticsQueryPackQuerySearchPropertiesRelated`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogAnalyticsQueryPackQuerySearchPropertiesRelated__added` | added | `{"type":"object","description":"The related metadata items for the function.","properties":{"categor...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterPatchProperties.properties.billingType.readOnly__deleted` | deleted | `false` |
| `definitions.ClusterProperties.properties.billingType.readOnly__deleted` | deleted | `false` |
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.body.readOnly__deleted` | deleted | `false` |
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.description.readOnly__deleted` | deleted | `false` |
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.displayName.readOnly__deleted` | deleted | `false` |

### Changes for `x-nullable`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterSku.properties.capacity['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.clusterResourceId['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.disableLocalAuth['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.enableDataExport['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.enableLogAccessUsingOnlyResourcePermissions['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.immediatePurgeDataOn30Days['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceFeatures.properties.unifiedSentinelBillingOnly['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceProperties.properties.retentionInDays['x-nullable__deleted']` | deleted | `true` |
| `definitions.WorkspaceSku.properties.capacityReservationLevel['x-nullable__deleted']` | deleted | `true` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataSource.properties.properties__deleted` | deleted | `{"$ref":"#/definitions/Object","description":"The data source properties in raw json format, each ki...` |
| `definitions.LogAnalyticsQueryPackQueryProperties.properties.related.properties__deleted` | deleted | `{"categories":{"type":"array","description":"The related categories for the function.","items":{"typ...` |
| `definitions.LogAnalyticsQueryPackQuerySearchProperties.properties.related.properties__deleted` | deleted | `{"categories":{"type":"array","description":"The related categories for the function.","items":{"typ...` |

### Changes for `nextLink`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LinkedServiceListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.LinkedStorageAccountsListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.WorkspaceListManagementGroupsResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |
| `definitions.WorkspaceListResult.properties.nextLink__added` | added | `{"type":"string","format":"uri","description":"[Placeholder] Discription for nextLink property"}` |

### Changes for `multipleOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResultStatistics.properties.progress.multipleOf__deleted` | deleted | `0.01` |
| `definitions.ResultStatistics.properties.scannedGb.multipleOf__deleted` | deleted | `0.01` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SearchGetSchemaResponse.properties.metadata['x-ms-client-name__deleted']` | deleted | `Metadata` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SummaryLogs.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","...` |
| `definitions.Table.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Workspace.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Cluster.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/TrackedResource` | `../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.Cluster.properties.identity.$ref` | `../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.Cluster.properties.identity.description` | `Resource's identity.` | `The managed service identities assigned to this resource.` |
| `definitions.ClusterPatch.properties.identity.$ref` | `../../../../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` | `../../../common-types/resource-management/v5/managedidentity.json#/definitions/ManagedServiceIdentity` |
| `definitions.ClusterPatchProperties.properties.keyVaultProperties.$ref` | `#/definitions/keyVaultProperties` | `#/definitions/KeyVaultProperties` |
| `definitions.ClusterProperties.properties.keyVaultProperties.$ref` | `#/definitions/keyVaultProperties` | `#/definitions/KeyVaultProperties` |
| `definitions.DataExport.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.DataSource.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.LinkedService.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.LinkedServiceListResult.description` | `The list linked service operation response.` | `[Placeholder] Discription for page model` |
| `definitions.LinkedServiceListResult.properties.value.description` | `The list of linked service instances` | `[Placeholder] Discription for value property` |
| `definitions.LinkedStorageAccountsListResult.description` | `The list linked storage accounts service operation response.` | `[Placeholder] Discription for page model` |
| `definitions.LinkedStorageAccountsListResult.properties.value.description` | `A list of linked storage accounts instances.` | `[Placeholder] Discription for value property` |
| `definitions.LinkedStorageAccountsResource.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.LogAnalyticsQueryPack.allOf[0].$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` | `../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.LogAnalyticsQueryPackQuery.allOf[0].$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.OperationStatus.properties.error.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `definitions.SavedSearch.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SavedSearchProperties.properties.category.description` | `The category of the saved search. This helps the user to find a saved search faster. ` | `The category of the saved search. This helps the user to find a saved search faster.` |
| `definitions.SearchMetadata.properties.requestId['x-ms-client-name']` | `SearchId` | `searchId` |
| `definitions.StorageInsight.allOf[0].$ref` | `../../../../../../common-types/resource-management/v1/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SummaryLogs.allOf[0].$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.SummaryLogsProperties.properties.provisioningState.description` | `Summary rule is in provisioning state. If set to 'updating' or 'deleting', indicates a resource lock due to an ongoing operation, preventing any update to the Summary rule until the operation is complete.` | `Table's current provisioning state. If set to 'updating', indicates a resource lock due to ongoing operation, forbidding any update to the table until the ongoing operation is concluded.` |
| `definitions.Table.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ProxyResource` | `../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` |
| `definitions.Workspace.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/TrackedResource` | `../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.WorkspaceFeatures.additionalProperties` | `true` | `{}` |
| `definitions.WorkspaceListManagementGroupsResult.description` | `The list workspace management groups operation response.` | `[Placeholder] Discription for page model` |
| `definitions.WorkspaceListManagementGroupsResult.properties.value.description` | `Gets or sets a list of management groups attached to the workspace.` | `[Placeholder] Discription for value property` |
| `definitions.WorkspaceListResult.description` | `The list workspaces operation response.` | `[Placeholder] Discription for page model` |
| `definitions.WorkspaceListResult.properties.value.description` | `A list of workspaces.` | `[Placeholder] Discription for value property` |
| `definitions.WorkspacePatch.allOf[0].$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/AzureEntityResource` | `../../../common-types/resource-management/v5/types.json#/definitions/TrackedResource` |
| `definitions.WorkspaceProperties.properties.publicNetworkAccessForIngestion.description` | `The network access type for operating on the Log Analytics Workspace. By default it is Enabled` | `The network access type for accessing Log Analytics ingestion.` |
| `definitions.WorkspaceProperties.properties.publicNetworkAccessForQuery.description` | `The network access type for operating on the Log Analytics Workspace. By default it is Enabled` | `The network access type for accessing Log Analytics query.` |
| `paths['/providers/microsoft.OperationalInsights/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.OperationalInsights/operations'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/clusters'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/deletedWorkspaces'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/queryPacks'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/workspaces'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.OperationalInsights/workspaces'].get['x-ms-examples'].WorkspacesSubscriptionList.$ref` | `./examples/WorkspacesSubscriptionList.json` | `./examples/WorkspacesSubscriptionListForWorkSpace.json` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/clusters/{clusterName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/deletedWorkspaces'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.parameters[0].$ref` | `../../../../../../common-types/resource-management/v6/types.json#/parameters/LocationParameter` | `../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/locations/{location}/workspaces/{workspaceName}/failover'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/{id}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/queryPacks/{queryPackName}/queries/search'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].put.parameters[1].name` | `dataExportName` | `workspaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].put.parameters[1].pattern` | `^[A-Za-z][A-Za-z0-9-]+[A-Za-z0-9]$` | `^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/dataExports/{dataExportName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/failback'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfigurationListResult` | `../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfigurationListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}'].get.responses.200.schema.$ref` | `../../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfiguration` | `../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/networkSecurityPerimeterConfigurations/{networkSecurityPerimeterConfigurationName}/reconcile'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].delete.responses.202.headers.Location.description` | `Operation Status Location URI` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].delete.responses.202.headers['Azure-AsyncOperation'].description` | `Operation Status Location URI` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.200.headers.Location.description` | `Operation Status Location URI` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.200.headers['Azure-AsyncOperation'].description` | `Operation Status Location URI` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.201.headers.Location.description` | `Operation Status Location URI` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.201.headers['Azure-AsyncOperation'].description` | `Operation Status Location URI` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/retrybin'].post.responses.202.headers.Location.description` | `Operation Status Location URI` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/retrybin'].post.responses.202.headers['Azure-AsyncOperation'].description` | `Operation Status Location URI` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/retrybin'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/start'].post.responses.202.headers['Azure-AsyncOperation'].description` | `Operation Status Location URI` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/start'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/summaryLogs/{summaryLogsName}/stop'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].delete.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].get.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].patch.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}'].put.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/cancelSearch'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.OperationalInsights/workspaces/{workspaceName}/tables/{tableName}/migrate'].post.responses.default.schema.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/ErrorResponse` | `../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |


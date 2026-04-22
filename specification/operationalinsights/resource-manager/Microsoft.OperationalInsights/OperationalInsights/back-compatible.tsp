import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.OperationalInsights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataExportProperties.destination);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Destination.metaData);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagementGroup.properties);

@@clientName(SearchMetadata.requestId, "SearchId");

@@clientName(StorageInsightListResult.`@odata.nextLink`, "odataNextLink");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspacePatch.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties);

@@clientName(DataExports.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataExport.properties);

@@clientName(DataSources.createOrUpdate::parameters.resource, "parameters");

@@clientName(LinkedServices.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LinkedService.properties);

@@clientLocation(LinkedStorageAccountsResources.get, "LinkedStorageAccounts");
@@clientLocation(LinkedStorageAccountsResources.createOrUpdate,
  "LinkedStorageAccounts"
);
@@clientName(LinkedStorageAccountsResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(LinkedStorageAccountsResources.delete,
  "LinkedStorageAccounts"
);
@@clientLocation(LinkedStorageAccountsResources.listByWorkspace,
  "LinkedStorageAccounts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LinkedStorageAccountsResource.properties);

@@clientLocation(LogAnalyticsQueryPackQueries.get, "Queries");
@@clientLocation(LogAnalyticsQueryPackQueries.put, "Queries");
@@clientName(LogAnalyticsQueryPackQueries.put::parameters.resource,
  "QueryPayload"
);
@@clientLocation(LogAnalyticsQueryPackQueries.update, "Queries");
@@clientName(LogAnalyticsQueryPackQueries.update::parameters.properties,
  "QueryPayload"
);
@@clientLocation(LogAnalyticsQueryPackQueries.delete, "Queries");
@@clientLocation(LogAnalyticsQueryPackQueries.list, "Queries");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LogAnalyticsQueryPackQuery.properties);

@@clientLocation(LogAnalyticsQueryPacks.get, "QueryPacks");
@@clientLocation(LogAnalyticsQueryPacks.createOrUpdate, "QueryPacks");
@@clientName(LogAnalyticsQueryPacks.createOrUpdate::parameters.resource,
  "LogAnalyticsQueryPackPayload"
);
@@clientLocation(LogAnalyticsQueryPacks.updateTags, "QueryPacks");
@@clientName(LogAnalyticsQueryPacks.updateTags::parameters.properties,
  "QueryPackTags"
);
@@clientLocation(LogAnalyticsQueryPacks.delete, "QueryPacks");
@@clientLocation(LogAnalyticsQueryPacks.listByResourceGroup, "QueryPacks");
@@clientLocation(LogAnalyticsQueryPacks.list, "QueryPacks");
@@clientLocation(LogAnalyticsQueryPacks.search, "Queries");
@@clientName(LogAnalyticsQueryPacks.search::parameters.body,
  "QuerySearchProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LogAnalyticsQueryPack.properties);

@@clientName(SavedSearches.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SavedSearch.properties);

@@clientLocation(StorageInsights.get, "StorageInsightConfigs");
@@clientLocation(StorageInsights.createOrUpdate, "StorageInsightConfigs");
@@clientName(StorageInsights.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(StorageInsights.delete, "StorageInsightConfigs");
@@clientLocation(StorageInsights.listByWorkspace, "StorageInsightConfigs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StorageInsight.properties);

@@clientName(Tables.createOrUpdate::parameters.resource, "parameters");
@@clientName(Tables.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Table.properties);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(Workspaces.update::parameters.properties, "parameters");
@@clientLocation(Workspaces.listByWorkspace, "AvailableServiceTiers");
@@clientLocation(Workspaces.gatewaysDelete, "Gateways");
@@clientName(Workspaces.gatewaysDelete, "Delete");
@@clientLocation(Workspaces.disable, "IntelligencePacks");
@@clientLocation(Workspaces.enable, "IntelligencePacks");
@@clientLocation(Workspaces.intelligencePacksList, "IntelligencePacks");
@@clientName(Workspaces.intelligencePacksList, "List");
@@clientLocation(Workspaces.managementGroupsList, "ManagementGroups");
@@clientName(Workspaces.managementGroupsList, "List");
@@clientLocation(Workspaces.schemaGet, "Schema");
@@clientName(Workspaces.schemaGet, "Get");
@@clientLocation(Workspaces.getSharedKeys, "SharedKeys");
@@clientLocation(Workspaces.regenerate, "SharedKeys");
@@clientLocation(Workspaces.usagesList, "Usages");
@@clientName(Workspaces.usagesList, "List");
@@clientLocation(Workspaces.purge, "WorkspacePurge");
@@clientLocation(Workspaces.getPurgeStatus, "WorkspacePurge");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Workspace.properties);

@@clientLocation(NetworkSecurityPerimeterConfigurations.getNSP, Workspaces);
@@clientLocation(NetworkSecurityPerimeterConfigurations.listNSP, Workspaces);
@@clientLocation(NetworkSecurityPerimeterConfigurations.reconcileNSP,
  Workspaces
);

@@clientLocation(SummaryLogsOperationGroup.get, "SummaryLogs");
@@clientLocation(SummaryLogsOperationGroup.createOrUpdate, "SummaryLogs");
@@clientName(SummaryLogsOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(QueryPacksOperationGroup.createOrUpdateWithoutName::parameters.body,
  "LogAnalyticsQueryPackPayload"
);
@@clientLocation(SummaryLogsOperationGroup.delete, "SummaryLogs");
@@clientLocation(SummaryLogsOperationGroup.listByWorkspace, "SummaryLogs");
@@clientLocation(SummaryLogsOperationGroup.start, "SummaryLogs");
@@clientLocation(SummaryLogsOperationGroup.stop, "SummaryLogs");
@@clientLocation(SummaryLogsOperationGroup.retryBin, "SummaryLogs");
@@clientName(SummaryLogsOperationGroup.retryBin::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SummaryLogs.properties);

@@clientLocation(OperationStatusesOperationGroup.get, "OperationStatuses");

@@clientLocation(QueryPacksOperationGroup.createOrUpdateWithoutName,
  "QueryPacks"
);

@@clientLocation(WorkspacesOperationGroup.failover, Workspaces);

@@clientLocation(DeletedWorkspacesOperationGroup.list, "DeletedWorkspaces");
@@clientLocation(DeletedWorkspacesOperationGroup.listByResourceGroup,
  "DeletedWorkspaces"
);
@@clientName(KeyVaultProperties, "keyVaultProperties");
@@clientName(SearchGetSchemaResponse.metadata, "Metadata");
/**
 * we add this model  in order to replace subscriptions model in CommonTypes with this model via alternateType decorator
 */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: Azure.Core.armResourceIdentifier;
}
@@alternateType(Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  Microsoft.OperationalInsights.AccessRulePropertiesSubscriptionsItem[],
  "go,javascript"
);

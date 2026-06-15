import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.OperationalInsights;

@@clientName(
  Microsoft.OperationalInsights,
  "OperationalInsightsManagementClient",
  "javascript,java"
);
@@clientName(
  Microsoft.OperationalInsights,
  "LogAnalyticsManagementClient",
  "python"
);
@@clientName(LogAnalyticsQueryPacks.search, "listSearch", "javascript");

@@clientName(NetworkSecurityPerimeterConfigurations.getNSP, "getNsp", "java");
@@clientName(NetworkSecurityPerimeterConfigurations.listNSP, "listNsp", "java");
@@clientName(
  NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "reconcileNsp",
  "java"
);
@@clientName(
  NetworkSecurityPerimeterConfigurations.getNSP,
  "GetNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfigurations.listNSP,
  "GetNetworkSecurityPerimeterConfigurations",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "ReconcileNetworkSecurityPerimeterConfiguration",
  "csharp"
);

@@clientName(DestinationMetaData, "DestinationMetadata", "java");

@@alternateType(
  Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  global.AccessRulePropertiesSubscriptionsItem[],
  "java,python"
);

// C# names for Network Security Perimeter common types need RP context.
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRule,
  "OperationalInsightsNetworkSecurityPerimeterAccessRule",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRuleDirection,
  "OperationalInsightsNetworkSecurityPerimeterAccessRuleDirection",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRuleProperties,
  "OperationalInsightsNetworkSecurityPerimeterAccessRuleProperties",
  "csharp"
);
@@clientName(
  global.AccessRulePropertiesSubscriptionsItem,
  "OperationalInsightsNetworkSecurityPerimeterAccessRuleSubscription",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.IssueType,
  "OperationalInsightsNetworkSecurityPerimeterIssueType",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter,
  "OperationalInsightsNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfiguration,
  "OperationalInsightsNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfigurationProperties,
  "OperationalInsightsNetworkSecurityPerimeterConfigurationProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfigurationProvisioningState,
  "OperationalInsightsNetworkSecurityPerimeterConfigurationProvisioningState",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityProfile,
  "OperationalInsightsNetworkSecurityProfile",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ProvisioningIssue,
  "OperationalInsightsNetworkSecurityPerimeterProvisioningIssue",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ProvisioningIssueProperties,
  "OperationalInsightsNetworkSecurityPerimeterProvisioningIssueProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ResourceAssociation,
  "OperationalInsightsNetworkSecurityPerimeterResourceAssociation",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ResourceAssociationAccessMode,
  "OperationalInsightsNetworkSecurityPerimeterResourceAssociationAccessMode",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.Severity,
  "OperationalInsightsNetworkSecurityPerimeterSeverity",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter.location,
  Azure.Core.azureLocation,
  "csharp"
);

@@clientName(
  Microsoft.OperationalInsights.ProvisioningStateEnum,
  "SummaryLogsProvisioningState",
  "java,python"
);
@@clientName(
  OperationalInsightsTableProvisioningState,
  "ProvisioningStateEnum",
  "java,python"
);

// Fix etag casing for backward compatibility
@@clientName(Microsoft.OperationalInsights.SearchMetadata.eTag, "etag", "java");

// C# customizations for migration parity with the previous AutoRest SDK.
@@clientName(LogAnalyticsQueryPackQuery, "LogAnalyticsQuery", "csharp");
@@clientName(Cluster, "OperationalInsightsCluster", "csharp");
@@clientName(DataExport, "OperationalInsightsDataExport", "csharp");
@@clientName(DataSource, "OperationalInsightsDataSource", "csharp");
@@clientName(
  DataSourcesListByWorkspaceParameters.$skiptoken,
  "skipToken",
  "csharp"
);
@@clientName(LinkedService, "OperationalInsightsLinkedService", "csharp");
@@clientName(
  LinkedStorageAccountsResource,
  "OperationalInsightsLinkedStorageAccounts",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterConfiguration,
  "OperationalInsightsNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(SavedSearch, "OperationalInsightsSavedSearch", "csharp");
@@clientName(SummaryLogs, "OperationalInsightsSummaryLogs", "csharp");
@@clientName(
  SummaryLogsRetryBin,
  "OperationalInsightsSummaryLogsRetryBin",
  "csharp"
);
@@clientName(Table, "OperationalInsightsTable", "csharp");
@@clientName(Workspace, "OperationalInsightsWorkspace", "csharp");

@@clientName(StorageAccount, "OperationalInsightsStorageAccount", "csharp");
@@alternateType(StorageAccount.id, armResourceIdentifier, "csharp");

@@clientName(
  LogAnalyticsQueryPackQuery.properties,
  "QueryProperties",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackQueryProperties.id,
  "ApplicationId",
  "csharp"
);
@@alternateType(LogAnalyticsQueryPackQueryProperties.id, uuid, "csharp");
@@clientName(
  LogAnalyticsQueryPackQueryProperties.timeCreated,
  "CreatedOn",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackQueryProperties.timeModified,
  "ModifiedOn",
  "csharp"
);
@@alternateType(LogAnalyticsQueryPackProperties.queryPackId, uuid, "csharp");
@@clientName(
  LogAnalyticsQueryPackProperties.timeCreated,
  "CreatedOn",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackProperties.timeModified,
  "ModifiedOn",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackQueryPropertiesRelated,
  "LogAnalyticsQueryRelatedMetadata",
  "csharp"
);
@@clientName(OperationStatus.error, "ErrorResponse", "csharp");

@@alternateType(DataSource.etag, eTag, "csharp");
@@alternateType(SavedSearch.etag, eTag, "csharp");
@@alternateType(Workspace.etag, eTag, "csharp");
@@alternateType(StorageInsight.eTag, eTag, "csharp");
@@alternateType(
  Workspace.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  WorkspacePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

@@clientName(BillingType, "OperationalInsightsBillingType", "csharp");
@@clientName(
  CapacityReservationProperties,
  "OperationalInsightsCapacityReservationProperties",
  "csharp"
);
@@clientName(
  AssociatedWorkspace,
  "OperationalInsightsClusterAssociatedWorkspace",
  "csharp"
);
@@clientName(AssociatedWorkspace.associateDate, "AssociatedOn", "csharp");
@@alternateType(ClusterProperties.clusterId, uuid, "csharp");
@@clientName(
  ClusterEntityStatus,
  "OperationalInsightsClusterEntityStatus",
  "csharp"
);
@@clientName(ClusterSkuNameEnum, "OperationalInsightsClusterSkuName", "csharp");
@@clientName(
  ClusterReplicationState,
  "OperationalInsightsClusterReplicationState",
  "csharp"
);
@@clientName(
  ClusterReplicationProperties,
  "OperationalInsightsClusterReplicationProperties",
  "csharp"
);
@@clientName(
  ClusterReplicationProperties.enabled,
  "IsReplicationEnabled",
  "csharp"
);
@@clientName(ClusterSku, "OperationalInsightsClusterSku", "csharp");
@@clientName(Capacity, "OperationalInsightsClusterCapacity", "csharp");
@@clientName(Type, "OperationalInsightsDataExportDestinationType", "csharp");
@@clientName(DataSourceKind, "OperationalInsightsDataSourceKind", "csharp");
@@clientName(
  DataIngestionStatus,
  "OperationalInsightsDataIngestionStatus",
  "csharp"
);
@@clientName(
  KeyVaultProperties,
  "OperationalInsightsKeyVaultProperties",
  "csharp"
);
@@clientName(
  LinkedServiceEntityStatus,
  "OperationalInsightsLinkedServiceEntityStatus",
  "csharp"
);
@@clientName(MetricName, "OperationalInsightsMetricName", "csharp");
@@clientName(
  PrivateLinkScopedResource,
  "OperationalInsightsPrivateLinkScopedResourceInfo",
  "csharp"
);
@@clientName(
  ProvisioningStateEnum,
  "OperationalInsightsNetworkSecurityPerimeterProvisioningState",
  "csharp"
);
@@clientName(
  PublicNetworkAccessType,
  "OperationalInsightsPublicNetworkAccessType",
  "csharp"
);
@@clientName(
  RuleTypeEnum,
  "OperationalInsightsNetworkSecurityPerimeterRuleType",
  "csharp"
);
@@clientName(Schema, "OperationalInsightsSchema", "csharp");
@@clientName(
  Severity,
  "OperationalInsightsNetworkSecurityPerimeterSeverity",
  "csharp"
);
@@clientName(SkuNameEnum, "OperationalInsightsSkuName", "csharp");
@@clientName(
  StatusCodeEnum,
  "OperationalInsightsNetworkSecurityPerimeterStatusCode",
  "csharp"
);
@@clientName(TablePlanEnum, "OperationalInsightsTablePlan", "csharp");
@@clientName(SearchResults, "OperationalInsightsTableSearchResults", "csharp");
@@clientName(RestoredLogs, "OperationalInsightsTableRestoredLogs", "csharp");
@@clientName(
  ResultStatistics,
  "OperationalInsightsTableResultStatistics",
  "csharp"
);
@@clientName(ResultStatistics.scannedGb, "ScannedGB", "csharp");
@@clientName(Column, "OperationalInsightsColumn", "csharp");
@@clientName(ColumnTypeEnum, "OperationalInsightsColumnType", "csharp");
@@clientName(
  ColumnDataTypeHintEnum,
  "OperationalInsightsColumnDataTypeHint",
  "csharp"
);
@@clientName(SourceEnum, "OperationalInsightsTableCreator", "csharp");
@@clientName(TableTypeEnum, "OperationalInsightsTableType", "csharp");
@@clientName(TableSubTypeEnum, "OperationalInsightsTableSubType", "csharp");
@@clientName(Tag, "OperationalInsightsTag", "csharp");
@@clientName(WorkspaceCapping, "OperationalInsightsWorkspaceCapping", "csharp");
@@clientName(
  WorkspaceEntityStatus,
  "OperationalInsightsWorkspaceEntityStatus",
  "csharp"
);
@@clientName(
  WorkspaceFailoverProperties,
  "OperationalInsightsWorkspaceFailoverProperties",
  "csharp"
);
@@clientName(
  WorkspaceFailoverState,
  "OperationalInsightsWorkspaceFailoverState",
  "csharp"
);
@@clientName(
  WorkspaceFeatures,
  "OperationalInsightsWorkspaceFeatures",
  "csharp"
);
@@clientName(
  WorkspaceReplicationProperties,
  "OperationalInsightsWorkspaceReplicationProperties",
  "csharp"
);
@@clientName(
  WorkspaceReplicationProperties.enabled,
  "IsReplicationEnabled",
  "csharp"
);
@@clientName(
  WorkspaceReplicationState,
  "OperationalInsightsWorkspaceReplicationState",
  "csharp"
);
@@clientName(WorkspaceSku, "OperationalInsightsWorkspaceSku", "csharp");
@@clientName(
  WorkspaceSkuNameEnum,
  "OperationalInsightsWorkspaceSkuName",
  "csharp"
);
@@clientName(
  CapacityReservationLevel,
  "OperationalInsightsWorkspaceCapacityReservationLevel",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous .NET base type for workspace patch data"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  WorkspacePatch,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);

@@alternateType(ClusterSku.capacity, Capacity, "csharp");
@@alternateType(
  WorkspaceSku.capacityReservationLevel,
  CapacityReservationLevel,
  "csharp"
);
@@clientName(
  TableProperties.retentionInDaysAsDefault,
  "IsRetentionInDaysAsDefault",
  "csharp"
);
@@clientName(
  TableProperties.totalRetentionInDaysAsDefault,
  "IsTotalRetentionInDaysAsDefault",
  "csharp"
);
@@alternateType(TableProperties.retentionInDaysAsDefault, boolean, "csharp");
@@alternateType(
  TableProperties.totalRetentionInDaysAsDefault,
  boolean,
  "csharp"
);

@@clientName(
  AvailableServiceTier,
  "OperationalInsightsAvailableServiceTier",
  "csharp"
);
@@clientName(AvailableServiceTier.enabled, "IsEnabled", "csharp");
@@clientName(AvailableServiceTier.lastSkuUpdate, "LastSkuUpdatedOn", "csharp");
@@alternateType(AvailableServiceTier.lastSkuUpdate, utcDateTime, "csharp");
@@clientName(IntelligencePack, "OperationalInsightsIntelligencePack", "csharp");
@@clientName(IntelligencePack.enabled, "IsEnabled", "csharp");
@@clientName(ManagementGroup, "OperationalInsightsManagementGroup", "csharp");
@@clientName(ManagementGroupProperties.created, "CreatedOn", "csharp");
@@clientName(
  ManagementGroupProperties.dataReceived,
  "DataReceivedOn",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackQuerySearchProperties,
  "LogAnalyticsQuerySearchProperties",
  "csharp"
);
@@clientName(
  LogAnalyticsQueryPackQuerySearchPropertiesRelated,
  "LogAnalyticsQuerySearchRelatedMetadata",
  "csharp"
);
@@clientName(
  SearchGetSchemaResponse,
  "OperationalInsightsSearchSchemaResult",
  "csharp"
);
@@clientName(
  SearchSchemaValue,
  "OperationalInsightsSearchSchemaValue",
  "csharp"
);
@@clientName(SearchSchemaValue.type, "SearchSchemaValueType", "csharp");
@@clientName(UsageMetric, "OperationalInsightsUsageMetric", "csharp");
@@clientName(SharedKeys, "OperationalInsightsWorkspaceSharedKeys", "csharp");
@@clientName(OperationStatus, "OperationalInsightsOperationStatus", "csharp");
@@clientName(
  TimeSelectorEnum,
  "OperationalInsightsSummaryTimeSelector",
  "csharp"
);
@@clientName(
  WorkspacePurgeBody,
  "OperationalInsightsWorkspacePurgeContent",
  "csharp"
);
@@clientName(
  WorkspacePurgeBodyFilters,
  "OperationalInsightsWorkspacePurgeFilter",
  "csharp"
);
@@clientName(
  WorkspacePurgeResponse,
  "OperationalInsightsWorkspacePurgeResult",
  "csharp"
);
@@clientName(WorkspacePurgeResponse.operationId, "OperationStringId", "csharp");
@@clientName(
  WorkspacePurgeStatusResponse,
  "OperationalInsightsWorkspacePurgeStatusResult",
  "csharp"
);
@@clientName(PurgeState, "OperationalInsightsWorkspacePurgeState", "csharp");
@@clientName(RuleDefinition, "OperationalInsightsSummaryRule", "csharp");
@@clientName(DataSourceType, "OperationalInsightsDataSourceType", "csharp");
@@clientName(DataExportProperties.dataExportId, "DataExportId", "csharp");
@@alternateType(DataExportProperties.dataExportId, uuid, "csharp");
@@clientName(DataExportProperties.enable, "IsEnabled", "csharp");
@@clientName(DataExportProperties.createdDate, "CreatedOn", "csharp");
@@alternateType(DataExportProperties.createdDate, utcDateTime, "csharp");
@@clientName(DataExportProperties.lastModifiedDate, "LastModifiedOn", "csharp");
@@alternateType(DataExportProperties.lastModifiedDate, utcDateTime, "csharp");
@@clientName(Destination.type, "DestinationType", "csharp");
@@alternateType(Destination.resourceId, armResourceIdentifier, "csharp");
@@clientName(
  CapacityReservationProperties.lastSkuUpdate,
  "LastSkuUpdatedOn",
  "csharp"
);
@@clientName(WorkspaceSku.lastSkuUpdate, "LastSkuUpdatedOn", "csharp");
@@clientName(
  WorkspaceFeatures.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(
  WorkspaceFeatures.enableDataExport,
  "IsDataExportEnabled",
  "csharp"
);
@@clientName(
  WorkspaceFeatures.enableLogAccessUsingOnlyResourcePermissions,
  "IsLogAccessUsingOnlyResourcePermissionsEnabled",
  "csharp"
);
@@clientName(
  WorkspaceFeatures.unifiedSentinelBillingOnly,
  "IsUnifiedSentinelBillingOnly",
  "csharp"
);
@@clientName(WorkspaceCapping.dailyQuotaGb, "DailyQuotaInGB", "csharp");
@@alternateType(WorkspaceProperties.customerId, uuid, "csharp");
@@alternateType(
  WorkspaceProperties.defaultDataCollectionRuleResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LinkedServiceProperties.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LinkedServiceProperties.writeAccessResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(
  LinkedStorageAccountsProperties.dataSourceType,
  "DataSourceType",
  "csharp"
);
@@alternateType(
  LinkedStorageAccountsProperties.storageAccountIds,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(Column.type, "ColumnType", "csharp");
@@clientName(ColumnDataTypeHintEnum.ip, "IP", "csharp");
@@clientName(StorageInsightState.ERROR, "Error", "csharp");

@@clientName(LogAnalyticsQueryPacks.search, "SearchQueries", "csharp");
@@clientName(Workspaces.listByWorkspace, "GetAvailableServiceTiers", "csharp");
@@clientName(
  Workspaces.intelligencePacksList,
  "GetIntelligencePacks",
  "csharp"
);
@@clientName(Workspaces.managementGroupsList, "GetManagementGroups", "csharp");
@@clientName(Workspaces.schemaGet, "GetSchemas", "csharp");
@@clientName(Workspaces.usagesList, "GetUsages", "csharp");
@@clientName(Workspaces.gatewaysDelete, "DeleteGateway", "csharp");
@@alternateType(GatewayNameParameter.gatewayId, uuid, "csharp");
@@clientName(Workspaces.disable, "DisableIntelligencePack", "csharp");
@@clientName(Workspaces.enable, "EnableIntelligencePack", "csharp");
@@clientName(Workspaces.regenerate, "RegenerateSharedKey", "csharp");
@@clientName(WorkspacesOperationGroup.failover, "FailoverWorkspace", "csharp");
@@alternateType(
  WorkspacesOperationGroup.failover::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  QueryPacksOperationGroup.createOrUpdateWithoutName,
  "CreateOrUpdateWithoutNameQueryPack",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous .NET pageable shape for the single-page saved search list operation"
@@markAsPageable(SavedSearches.listByWorkspace, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve previous .NET pageable shape for workspace schema values"
@@markAsPageable(Workspaces.schemaGet, "csharp");

namespace Microsoft.OperationalInsights {
  #suppress "@azure-tools/typespec-azure-core/no-enum" "Preserve previous .NET numeric enum shape used by @@alternateType for SDK compatibility"
  enum Capacity {
    FiveHundred: 500,
    TenHundred: 1000,
    TwoThousand: 2000,
    FiveThousand: 5000,
  }

  #suppress "@azure-tools/typespec-azure-core/no-enum" "Preserve previous .NET numeric enum shape used by @@alternateType for SDK compatibility"
  enum CapacityReservationLevel {
    OneHundred: 100,
    TwoHundred: 200,
    ThreeHundred: 300,
    FourHundred: 400,
    FiveHundred: 500,
    TenHundred: 1000,
    TwoThousand: 2000,
    FiveThousand: 5000,
    TenThousand: 10000,
    TwentyFiveThousand: 25000,
    FiftyThousand: 50000,
  }
}

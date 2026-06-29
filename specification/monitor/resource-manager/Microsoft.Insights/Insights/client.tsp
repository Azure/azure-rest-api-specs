import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./DataCollectionApi/main.tsp";
import "./PrivateLinkScopesApi/main.tsp";
import "./AutoScaleApi/main.tsp";
import "./ActivityLogsApi/main.tsp";
import "./MetricsApi/main.tsp";
import "./ServiceDiagnosticsSettingsApi/main.tsp";
import "./AlertRulesIncidentsApi/main.tsp";
import "./LogProfilesApi/main.tsp";
import "./ActivityLogAlertsApi/main.tsp";
import "./MetricAlertApi/main.tsp";
import "./ScheduledQueryRuleApi/main.tsp";
import "./MetricBaselinesApi/main.tsp";
import "./ActionGroupsApi/main.tsp";
import "./NetworkSecurityPerimeterApi/main.tsp";
import "./Common/main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Microsoft.Insights;
using ActionGroupsApi;
using ActivityLogAlertsApi;
using AlertRulesIncidentsApi;
using ScheduledQueryRuleApi;
using AutoScaleApi;
using DataCollectionApi;
using LogProfilesApi;
using MetricAlertApi;
using Microsoft.Common;
using PrivateLinkScopesApi;
using MetricsApi;
using ServiceDiagnosticsSettingsApi;

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "CombineClient",
  service: [
    DataCollectionApi,
    PrivateLinkScopesApi,
    AutoScaleApi,
    ActivityLogsApi,
    MetricsApi,
    ServiceDiagnosticsSettingsApi,
    AlertRulesIncidentsApi,
    LogProfilesApi,
    ActivityLogAlertsApi,
    MetricAlertApi,
    ScheduledQueryRuleApi,
    MetricBaselinesApi,
    ActionGroupsApi,
    NetworkSecurityPerimeterApi
  ],
  autoMergeService: true,
})
namespace Microsoft.InsightsCombinedClient;

@@clientName(
  Microsoft.InsightsCombinedClient,
  "MonitorClient",
  "java,javascript"
);
@@clientName(
  Microsoft.InsightsCombinedClient,
  "MonitorManagementClient",
  "python"
);

// C# compatibility names from the shipped AutoRest-based Azure.ResourceManager.Monitor package.
@@clientName(ActionGroupsApi.ActionGroup, "ActionGroupProperties", "csharp");
@@clientName(ActionGroupsApi.ActionGroup.enabled, "IsEnabled", "csharp");
@@clientName(ActionGroupsApi.ActionGroupResource, "ActionGroup", "csharp");
@@clientName(
  ActionGroupsApi.ActionGroupPatchBody,
  "ActionGroupPatch",
  "csharp"
);
@@clientName(
  ActionGroupsApi.ActionGroupPatch,
  "ActionGroupPatchProperties",
  "csharp"
);
@@clientName(ActionGroupsApi.ActionGroupPatch.enabled, "IsEnabled", "csharp");
@@clientName(
  ActionGroupsApi.NotificationRequestBody,
  "NotificationContent",
  "csharp"
);
@@clientName(
  ActionGroupsApi.TestNotificationDetailsResponse,
  "NotificationStatus",
  "csharp"
);
@@clientName(ActionGroupsApi.Context, "NotificationContext", "csharp");
@@clientName(
  ActionGroupsApi.ActionDetail,
  "NotificationActionDetail",
  "csharp"
);
@@clientName(
  ActionGroupsApi.EnableRequest,
  "ActionGroupEnableContent",
  "csharp"
);
@@clientName(
  ActionGroupsApi.ActionGroupResources.createNotificationsAtActionGroupResourceLevel,
  "CreateNotifications",
  "csharp"
);
@@clientName(
  ActionGroupsApi.ActionGroupResources.getTestNotificationsAtActionGroupResourceLevel,
  "GetNotificationStatus",
  "csharp"
);
@@clientName(
  ActivityLogsApi.ActivityLogsOperationGroup.list,
  "GetActivityLogs",
  "csharp"
);
@@clientName(
  ActivityLogsApi.TenantActivityLogsOperationGroup.list,
  "GetTenantActivityLogs",
  "csharp"
);
@@clientName(
  ActivityLogsApi.EventCategoriesOperationGroup.list,
  "GetEventCategories",
  "csharp"
);
@@clientName(AlertRulesIncidentsApi.Incident, "MonitorIncident", "csharp");
@@clientName(
  MetricAlertApi.MetricAlertResources.list,
  "GetAllMetricAlertsStatus",
  "csharp"
);
@@clientName(
  MetricAlertApi.MetricAlertResources.listByName,
  "GetAllMetricAlertsStatusByName",
  "csharp"
);
@@clientName(
  MetricAlertApi.ResolveConfiguration.autoResolved,
  "IsAutoResolved",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "preserve the shipped C# overload name for resource-scope metric retrieval"
@@clientName(
  MetricsApi.MetricsOperationGroup.list,
  "GetMonitorMetrics",
  "csharp"
);
@@clientName(MetricsApi.Response, "MonitorMetricsResult", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "preserve the shipped C# overload name for subscription-scope metric retrieval"
@@clientName(
  MetricsApi.MetricsOperationGroup.listAtSubscriptionScope,
  "GetMonitorMetrics",
  "csharp"
);
@@clientName(
  MetricsApi.MetricsOperationGroup.listAtSubscriptionScopePost,
  "GetMonitorMetricsWithPost",
  "csharp"
);
@@clientName(
  MetricsApi.AggregationType,
  "MonitorMetricAggregationType",
  "csharp"
);
@@clientName(
  MetricsApi.SubscriptionScopeMetricsRequestBodyParameters,
  "SubscriptionScopeMetricsContent",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.BaselinesOperationGroup.list,
  "GetMonitorMetricBaselines",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionEndpointResources.listByDataCollectionEndpoint,
  "GetDataCollectionRuleAssociations",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionRuleResources.listByRule,
  "GetDataCollectionRuleAssociationsByRule",
  "csharp"
);
@@clientName(
  ActivityLogAlertsApi.ActivityLogAlertResource,
  "ActivityLogAlert",
  "csharp"
);
@@clientName(
  ActivityLogAlertsApi.AlertRuleProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  ActivityLogAlertsApi.AlertRulePatchProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  AutoScaleApi.AutoscaleSetting,
  "AutoscaleSettingProperties",
  "csharp"
);
@@clientName(
  AutoScaleApi.AutoscaleSettingResource,
  "AutoscaleSetting",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionEndpoint,
  "DataCollectionEndpointProperties",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionEndpointResource,
  "DataCollectionEndpoint",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionRule,
  "DataCollectionRuleProperties",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionRuleResource,
  "DataCollectionRule",
  "csharp"
);
@@clientName(LogProfilesApi.LogProfileResource, "LogProfile", "csharp");
@@clientName(
  LogProfilesApi.LogProfileCollection,
  "LogProfileListResult",
  "csharp"
);
@@alternateType(
  LogProfilesApi.LogProfileProperties.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LogProfilesApi.LogProfileProperties.serviceBusRuleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LogProfilesApi.LogProfileProperties.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@clientName(MetricAlertApi.MetricAlertResource, "MetricAlert", "csharp");
@@clientName(
  MetricAlertApi.MetricAlertProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  MetricAlertApi.MetricAlertProperties.autoMitigate,
  "IsAutoMitigateEnabled",
  "csharp"
);
@@clientName(
  MetricAlertApi.MetricAlertPropertiesPatch.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  MetricAlertApi.MetricAlertPropertiesPatch.autoMitigate,
  "IsAutoMitigateEnabled",
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertProperties.targetResourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertProperties.targetResourceRegion,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertPropertiesPatch.targetResourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertPropertiesPatch.targetResourceRegion,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  ScheduledQueryRuleApi.ScheduledQueryRuleResource,
  "ScheduledQueryRule",
  "csharp"
);
// DCR association and diagnostic setting are extension resources whose GA SDK surface
// used resource names without the TypeSpec proxy/service prefixes.
@@clientName(
  DataCollectionApi.DataCollectionRuleAssociation,
  "DataCollectionRuleAssociationProperties",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionRuleAssociationProxyOnlyResource,
  "DataCollectionRuleAssociation",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownDataCollectionRuleAssociationProvisioningState,
  "DataCollectionRuleAssociationProvisioningState",
  "csharp"
);
@@clientName(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettings,
  "DiagnosticSettingsProperties",
  "csharp"
);
@@clientName(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettingsResource,
  "ServiceDiagnosticSetting",
  "csharp"
);
@@alternateType(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettingsResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettings.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettings.serviceBusRuleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettings.eventHubAuthorizationRuleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ServiceDiagnosticsSettingsApi.ServiceDiagnosticSettings.workspaceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.AzureMonitorPrivateLinkScope,
  "MonitorPrivateLinkScope",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.PrivateEndpointConnection,
  "MonitorPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.PrivateLinkResource,
  "MonitorPrivateLinkResource",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.ScopedResourceKind,
  "MonitorScopedResourceKind",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.ScopedResourceProvisioningState,
  "MonitorScopedResourceProvisioningState",
  "csharp"
);
@@usage(PrivateLinkScopesApi.PrivateLinkResource, Usage.input, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "restore flattened private link resource data shape for C# compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateLinkScopesApi.PrivateLinkResource.properties,
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.ScopedResource,
  "MonitorPrivateLinkScopedResource",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.AzureMonitorPrivateLinkScopeProperties.provisioningState,
  "PrivateLinkScopeProvisioningState",
  "csharp"
);
@@alternateType(
  PrivateLinkScopesApi.ScopedResourceProperties.linkedResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PrivateLinkScopesApi.ScopedResourceProperties.subscriptionLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.ScopedResourceProperties.provisioningState,
  "ScopedResourceProvisioningState",
  "csharp"
);

// Split NSP operations by resource type for C# so each generated client has a single API version.
// Keeping ActionGroup NSP operations in ActionGroups mixes 2021-10-01 with 2024-10-01-preview.
@@clientLocation(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.getNSP,
  "NspActionGroup",
  "csharp"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.listNSP,
  "NspActionGroup",
  "csharp"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "NspActionGroup",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.getNSP,
  "GetNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.listNSP,
  "GetNetworkSecurityPerimeterConfigurations",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.NetworkSecurityPerimeterConfigurations.reconcileNSP,
  "ReconcileNetworkSecurityPerimeterConfiguration",
  "csharp"
);

// Split DataCollectionEndpoint NSP operations from the main DataCollectionEndpoints client.
// The main endpoint operations use 2024-03-11, while NSP operations use 2021-10-01.
@@clientLocation(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.getNSP,
  "NspDataCollectionEndpoint",
  "csharp"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.listNSP,
  "NspDataCollectionEndpoint",
  "csharp"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.reconcileNSP,
  "NspDataCollectionEndpoint",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.getNSP,
  "GetNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.listNSP,
  "GetNetworkSecurityPerimeterConfigurations",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.DataCollectionEndpoints.reconcileNSP,
  "ReconcileNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownPerfCounterDataSourceStreams,
  "PerfCounterDataSourceStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownWindowsEventLogDataSourceStreams,
  "WindowsEventLogDataSourceStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownSyslogDataSourceStreams,
  "SyslogDataSourceStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownSyslogDataSourceFacilityNames,
  "SyslogDataSourceFacilityName",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownExtensionDataSourceStreams,
  "ExtensionDataSourceStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFilesDataSourceFormat,
  "LogFilesDataSourceFormat",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownPrometheusForwarderDataSourceStreams,
  "DataCollectionRuleKnownPrometheusForwarderDataSourceStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.EventHubDestination,
  "DataCollectionRuleEventHubDestination",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownDataFlowStreams,
  "DataFlowStream",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownColumnDefinitionType,
  "DataColumnDefinitionType",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat,
  "LogFileTextSettingsRecordStartTimestampFormat",
  "csharp"
);
@@clientName(
  DataCollectionApi.LocationSpec,
  "DataCollectionRuleBcdrLocationSpec",
  "csharp"
);
@@clientName(
  DataCollectionApi.FailoverConfigurationSpec,
  "DataCollectionRuleBcdrFailoverConfigurationSpec",
  "csharp"
);
@@clientName(
  DataCollectionApi.Metadata,
  "DataCollectionRuleRelatedResourceMetadata",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLocationSpecProvisioningStatus,
  "DataCollectionRuleBcdrLocationSpecProvisioningStatus",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownSyslogDataSourceLogLevels,
  "SyslogDataSourceLogLevel",
  "csharp"
);
@@clientName(
  DataCollectionApi.EventHubDirectDestination,
  "DataCollectionRuleEventHubDirectDestination",
  "csharp"
);
@@clientName(
  DataCollectionApi.EventHubDataSource,
  "DataCollectionRuleEventHubDataSource",
  "csharp"
);
@@clientName(
  DataCollectionApi.StorageBlobDestination,
  "DataCollectionRuleStorageBlobDestination",
  "csharp"
);
@@clientName(
  DataCollectionApi.StorageTableDestination,
  "DataCollectionRuleStorageTableDestination",
  "csharp"
);
@@clientName(
  DataCollectionApi.StorageBlob,
  "DataCollectionRuleEnrichmentStorageBlob",
  "csharp"
);
@@clientName(
  DataCollectionApi.ApplicationInsights,
  "MonitorApplicationInsightsReference",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataFlow.captureOverflow,
  "ShouldCaptureOverflow",
  "csharp"
);
@@clientName(
  DataCollectionApi.OtelLogsDataSource.replaceResourceIdWithReference,
  "ShouldReplaceResourceIdWithReference",
  "csharp"
);
@@clientName(
  DataCollectionApi.OtelLogsDirectDataSource.replaceResourceIdWithReference,
  "ShouldReplaceResourceIdWithReference",
  "csharp"
);
@@clientName(
  DataCollectionApi.OtelTracesDataSource.replaceResourceIdWithReference,
  "ShouldReplaceResourceIdWithReference",
  "csharp"
);
@@clientName(
  DataCollectionApi.OtelTracesDirectDataSource.replaceResourceIdWithReference,
  "ShouldReplaceResourceIdWithReference",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.AccessModeSettings,
  "MonitorPrivateLinkAccessModeSettings",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.AccessModeSettingsExclusion,
  "MonitorPrivateLinkAccessModeSettingsExclusion",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.AccessMode,
  "MonitorPrivateLinkAccessMode",
  "csharp"
);
@@clientName(AutoScaleApi.TimeWindow, "MonitorTimeWindow", "csharp");
@@clientName(AutoScaleApi.Recurrence, "MonitorRecurrence", "csharp");
@@clientName(AutoScaleApi.ScaleAction, "MonitorScaleAction", "csharp");
@@clientName(AutoScaleApi.ScaleCapacity, "MonitorScaleCapacity", "csharp");
@@clientName(AutoScaleApi.ScaleRule, "AutoscaleRule", "csharp");
@@clientName(
  AutoScaleApi.TimeAggregationType,
  "MetricTriggerTimeAggregationType",
  "csharp"
);
@@clientName(AutoScaleApi.ScaleDirection, "MonitorScaleDirection", "csharp");
@@clientName(
  AutoScaleApi.ComparisonOperationType,
  "MetricTriggerComparisonOperator",
  "csharp"
);
@@clientName(AutoScaleApi.ScaleType, "MonitorScaleType", "csharp");
@@clientName(
  AutoScaleApi.ScaleRuleMetricDimension,
  "AutoscaleRuleMetricDimension",
  "csharp"
);
@@clientName(
  AutoScaleApi.MetricTrigger.metricResourceUri,
  "MetricResourceId",
  "csharp"
);
@@alternateType(
  AutoScaleApi.MetricTrigger.metricResourceUri,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  AutoScaleApi.MetricTrigger.operator,
  "ComparisonOperator",
  "csharp"
);
@@clientName(
  AutoScaleApi.MetricTrigger.dividePerInstance,
  "IsDividedPerInstance",
  "csharp"
);
@@clientName(AutoScaleApi.ScaleAction.type, "ScaleType", "csharp");
@@clientName(AutoScaleApi.TimeWindow.start, "StartOn", "csharp");
@@clientName(AutoScaleApi.TimeWindow.end, "EndOn", "csharp");
@@clientName(
  MetricAlertApi.AggregationTypeEnum,
  "MetricCriteriaTimeAggregationType",
  "csharp"
);
@@clientName(MetricAlertApi.Operator, "MetricCriteriaOperator", "csharp");
@@clientName(
  AutoScaleApi.ScaleRuleMetricDimensionOperationType.Equals,
  "EqualsValue",
  "csharp"
);
@@clientName(MetricAlertApi.Operator.Equals, "EqualsValue", "csharp");
@@clientName(AutoScaleApi.AutoscaleSetting.enabled, "IsEnabled", "csharp");
@@clientName(
  AutoScaleApi.AutoscaleSetting.notifications,
  "Notifications",
  "csharp"
);
@@clientName(
  AutoScaleApi.AutoscaleSetting.targetResourceUri,
  "TargetResourceId",
  "csharp"
);
@@alternateType(
  AutoScaleApi.AutoscaleSetting.targetResourceUri,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AutoScaleApi.AutoscaleSetting.targetResourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  AutoScaleApi.PredictiveResponse,
  "AutoscaleSettingPredicativeResult",
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionEndpointResource.etag,
  "ETag",
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionEndpointResource.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.Legacy.EntityTagProperty.etag,
  Azure.Core.eTag,
  "csharp"
);
@@clientName(
  DataCollectionApi.DataCollectionEndpointResource.identity,
  "Identity",
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionEndpointResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionRuleResource.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionRuleResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  MetricAlertApi.MetricAlertResourcePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ScheduledQueryRuleApi.ScheduledQueryRuleResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ScheduledQueryRuleApi.ScheduledQueryRuleResourcePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionRule.dataCollectionEndpointId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionRuleAssociation.dataCollectionRuleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataCollectionApi.DataCollectionRuleAssociation.dataCollectionEndpointId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataCollectionApi.Metadata.provisionedByResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataCollectionApi.StorageBlob.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataCollectionApi.AdxDestination.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DataCollectionApi.AdxDestination.ingestionUri, url, "csharp");
@@clientName(
  DataCollectionApi.DataCollectionRuleAssociationProxyOnlyResource.etag,
  "ETag",
  "csharp"
);
@@clientName(
  ActivityLogAlertsApi.AlertRuleLeafCondition.equals,
  "EqualsValue",
  "csharp"
);
@@clientName(
  ActivityLogAlertsApi.AlertRuleAnyOfOrLeafCondition,
  "ActivityLogAlertAnyOfOrLeafCondition",
  "csharp"
);
@@clientName(ActionGroupsApi.EmailReceiver, "MonitorEmailReceiver", "csharp");
@@clientName(ActionGroupsApi.SmsReceiver, "MonitorSmsReceiver", "csharp");
@@clientName(
  ActionGroupsApi.WebhookReceiver,
  "MonitorWebhookReceiver",
  "csharp"
);
@@clientName(ActionGroupsApi.ItsmReceiver, "MonitorItsmReceiver", "csharp");
@@clientName(
  ActionGroupsApi.AzureAppPushReceiver,
  "MonitorAzureAppPushReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.AutomationRunbookReceiver,
  "MonitorAutomationRunbookReceiver",
  "csharp"
);
@@clientName(ActionGroupsApi.VoiceReceiver, "MonitorVoiceReceiver", "csharp");
@@clientName(
  ActionGroupsApi.LogicAppReceiver,
  "MonitorLogicAppReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.AzureFunctionReceiver,
  "MonitorAzureFunctionReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.ArmRoleReceiver,
  "MonitorArmRoleReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.EventHubReceiver,
  "MonitorEventHubReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.IncidentReceiver,
  "MonitorIncidentReceiver",
  "csharp"
);
@@clientName(
  ActionGroupsApi.IncidentServiceConnection,
  "MonitorIncidentServiceConnection",
  "csharp"
);
@@clientName(
  ActionGroupsApi.IncidentManagementService,
  "MonitorIncidentManagementService",
  "csharp"
);
@@clientName(ActionGroupsApi.ReceiverStatus, "MonitorReceiverStatus", "csharp");
@@clientName(
  DataCollectionApi.KnownDataCollectionEndpointResourceKind,
  "DataCollectionEndpointResourceKind",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownDataCollectionEndpointProvisioningState,
  "DataCollectionEndpointProvisioningState",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownPublicNetworkAccessOptions,
  "MonitorPublicNetworkAccess",
  "csharp"
);
@@clientName(
  DataCollectionApi.PrivateLinkScopedResource,
  "DataCollectionRulePrivateLinkScopedResourceInfo",
  "csharp"
);
@@clientName(
  DataCollectionApi.ColumnDefinition.type,
  "DefinitionType",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownDataCollectionRuleResourceKind,
  "DataCollectionRuleResourceKind",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownDataCollectionRuleProvisioningState,
  "DataCollectionRuleProvisioningState",
  "csharp"
);
@@clientName(
  DataCollectionApi.StreamDeclaration,
  "DataStreamDeclaration",
  "csharp"
);
@@clientName(
  DataCollectionApi.ColumnDefinition,
  "DataColumnDefinition",
  "csharp"
);
@@clientName(ScheduledQueryRuleApi.Kind, "ScheduledQueryRuleKind", "csharp");
@@clientName(
  ScheduledQueryRuleApi.TimeAggregation,
  "ScheduledQueryRuleTimeAggregationType",
  "csharp"
);
@@clientName(
  Microsoft.Common.CriterionType,
  "ScheduledQueryRuleCriterionType",
  "csharp"
);
@@clientName(ScheduledQueryRuleApi.Dimension, "MonitorDimension", "csharp");
@@clientName(
  ScheduledQueryRuleApi.DimensionOperator,
  "MonitorDimensionOperator",
  "csharp"
);
@@clientName(
  ScheduledQueryRuleApi.Condition,
  "ScheduledQueryRuleCondition",
  "csharp"
);
@@clientName(
  ScheduledQueryRuleApi.Actions,
  "ScheduledQueryRuleActions",
  "csharp"
);
@@clientName(
  AutoScaleApi.AutoscaleSetting.name,
  "AutoscaleSettingName",
  "csharp"
);
@@clientName(ActivityLogsApi.EventData, "EventDataInfo", "csharp");
@@clientName(
  ActivityLogsApi.HttpRequestInfo,
  "EventDataHttpRequestInfo",
  "csharp"
);
@@clientName(
  ActivityLogsApi.HttpRequestInfo.clientIpAddress,
  "ClientIPAddress",
  "csharp"
);
@@alternateType(
  ActivityLogsApi.HttpRequestInfo.clientIpAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(ActivityLogsApi.EventLevel, "MonitorEventLevel", "csharp");
@@clientName(LocalizableString, "MonitorLocalizableString", "csharp");
@@clientName(
  MetricBaselinesApi.SingleMetricBaseline,
  "MonitorSingleMetricBaseline",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.TimeSeriesBaseline,
  "MonitorTimeSeriesBaseline",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.MetricSingleDimension,
  "MonitorMetricSingleDimension",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.SingleBaseline,
  "MonitorSingleBaseline",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.BaselineSensitivity,
  "MonitorBaselineSensitivity",
  "csharp"
);
@@clientName(
  MetricBaselinesApi.BaselineMetadata,
  "MonitorBaselineMetadata",
  "csharp"
);
@@clientName(MetricsApi.MetricDefinition, "MonitorMetricDefinition", "csharp");
@@clientName(
  MetricsApi.MetricDefinition.primaryAggregationType,
  "PrimaryAggregationKind",
  "csharp"
);
@@clientName(
  MetricsApi.MetricDefinition.supportedAggregationTypes,
  "SupportedAggregationKinds",
  "csharp"
);
@@clientName(MetricsApi.MetricClass, "MonitorMetricClass", "csharp");
@@clientName(
  MetricsApi.MetricAvailability,
  "MonitorMetricAvailability",
  "csharp"
);
@@clientName(
  MetricsApi.MetricAggregationType,
  "MonitorAggregationKind",
  "csharp"
);
@@clientName(MetricsApi.MetricUnit, "MonitorMetricUnit", "csharp");
@@clientName(MetricsApi.MetricNamespace, "MonitorMetricNamespace", "csharp");
@@clientName(
  MetricsApi.NamespaceClassification,
  "MonitorNamespaceClassification",
  "csharp"
);
@@clientName(MetricsApi.MetricResultType, "MonitorMetricResultType", "csharp");
@@clientName(
  MetricsApi.MetricNamespaceName.metricNamespaceName,
  "MetricNamespaceNameValue",
  "csharp"
);
@@clientName(MetricsApi.Metric, "MonitorMetric", "csharp");
@@clientName(MetricsApi.Metric.type, "MetricType", "csharp");
@@clientName(
  MetricsApi.TimeSeriesElement,
  "MonitorTimeSeriesElement",
  "csharp"
);
@@clientName(MetricsApi.MetadataValue, "MonitorMetadataValue", "csharp");
@@clientName(MetricsApi.MetricValue, "MonitorMetricValue", "csharp");
@@clientName(
  AutoScaleApi.AutoscaleSettingResources.predictiveMetricGet,
  "GetPredictiveMetric",
  "csharp"
);
@@clientName(
  MetricsApi.MetricDefinitionsOperationGroup.list,
  "GetMonitorMetricDefinitions",
  "csharp"
);
@@clientName(
  MetricsApi.MetricDefinitionsOperationGroup.listAtSubscriptionScope,
  "GetSubscriptionMonitorMetricDefinitions",
  "csharp"
);
@@clientName(
  MetricsApi.MetricNamespacesOperationGroup.list,
  "GetMonitorMetricNamespaces",
  "csharp"
);
@@clientName(ResultType, "MonitorResultType", "csharp");
@@clientName(
  MetricsApi.SubscriptionScopeMetricDefinition.primaryAggregationType,
  "PrimaryAggregationKind",
  "csharp"
);
@@clientName(
  MetricsApi.SubscriptionScopeMetricDefinition.supportedAggregationTypes,
  "SupportedAggregationKinds",
  "csharp"
);
@@clientName(
  ServiceDiagnosticsSettingsApi.MetricSettings.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  ServiceDiagnosticsSettingsApi.LogSettings.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(Microsoft.Common.RetentionPolicy.enabled, "IsEnabled", "csharp");
@@clientName(ActionGroupsApi.ActionDetail.SendTime, "SendOn", "csharp");
@@clientName(
  ActionGroupsApi.TestNotificationDetailsResponse.completedTime,
  "CompletedOn",
  "csharp"
);
@@clientName(
  ActionGroupsApi.TestNotificationDetailsResponse.createdTime,
  "CreatedOn",
  "csharp"
);
@@clientName(
  ScheduledQueryRuleApi.ScheduledQueryRuleProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  ScheduledQueryRuleApi.RuleResolveConfiguration.autoResolved,
  "IsAutoResolved",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(
  PrivateLinkScopesApi.PrivateLinkResources.listByPrivateLinkScope,
  "GetAllPrivateLinkResources",
  "csharp"
);

// LRO status polling endpoints are implementation details and should not generate public C# SDK methods.
@@scope(PrivateLinkScopeOperationStatusOperationGroup.get, "!csharp");

// Monitor C# names for Network Security Perimeter common types need package and feature context.
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter,
  "MonitorNetworkSecurityPerimeter",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfiguration,
  "MonitorNetworkSecurityPerimeterConfigurationData",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfigurationProperties,
  "MonitorNetworkSecurityPerimeterConfigurationProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeterConfigurationProvisioningState,
  "MonitorNetworkSecurityPerimeterConfigurationProvisioningState",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.NetworkSecurityProfile,
  "MonitorNetworkSecurityProfile",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRule,
  "MonitorNetworkSecurityPerimeterConfigurationAccessRule",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRuleDirection,
  "MonitorNetworkSecurityPerimeterConfigurationAccessRuleDirection",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.AccessRuleProperties,
  "MonitorNetworkSecurityPerimeterConfigurationAccessRuleProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.IssueType,
  "MonitorNetworkSecurityPerimeterConfigurationIssueType",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ProvisioningIssue,
  "MonitorNetworkSecurityPerimeterConfigurationProvisioningIssue",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ProvisioningIssueProperties,
  "MonitorNetworkSecurityPerimeterConfigurationProvisioningIssueProperties",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ResourceAssociation,
  "MonitorNetworkSecurityPerimeterConfigurationResourceAssociation",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ResourceAssociationAccessMode,
  "MonitorNetworkSecurityPerimeterConfigurationResourceAssociationAccessMode",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.Severity,
  "MonitorNetworkSecurityPerimeterConfigurationIssueSeverity",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.NetworkSecurityPerimeter.location,
  Azure.Core.azureLocation,
  "csharp"
);

/** Days of the week accepted by Monitor recurring schedules. */
union MonitorDayOfWeek {
  string,

  /** Sunday. */
  Sunday: "Sunday",

  /** Monday. */
  Monday: "Monday",

  /** Tuesday. */
  Tuesday: "Tuesday",

  /** Wednesday. */
  Wednesday: "Wednesday",

  /** Thursday. */
  Thursday: "Thursday",

  /** Friday. */
  Friday: "Friday",

  /** Saturday. */
  Saturday: "Saturday",
}

/** Monitor autoscale operation type. */
union MonitorOperationType {
  string,

  /** Scale operation. */
  Scale: "Scale",
}

/** Monitor condition comparison operator. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "C# compatibility alternate type must generate the shipped MonitorConditionOperator extensible enum"
enum MonitorConditionOperator {
  /** Greater than. */
  GreaterThan: "GreaterThan",

  /** Greater than or equal. */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /** Less than. */
  LessThan: "LessThan",

  /** Less than or equal. */
  LessThanOrEqual: "LessThanOrEqual",

  /** Equals. */
  EqualsValue: "Equals",
}

@@alternateType(
  AutoScaleApi.RecurrentSchedule.days,
  MonitorDayOfWeek[],
  "csharp"
);
@@alternateType(
  AutoScaleApi.AutoscaleNotification.operation,
  MonitorOperationType,
  "csharp"
);
@@alternateType(
  ScheduledQueryRuleApi.Condition.operator,
  MonitorConditionOperator,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateLinkScopesApi.PrivateEndpointConnections.listByPrivateLinkScope,
  "csharp,java,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateLinkScopesApi.PrivateLinkResources.listByPrivateLinkScope,
  "csharp,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  MetricAlertApi.MetricAlertResources.list,
  "csharp,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "list should be pageable"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  MetricAlertApi.MetricAlertResources.listByName,
  "csharp,java"
);

// ActivityLogAlerts - rename back to match fluent SDK expected names
@@clientName(
  ActivityLogAlertsApi.AlertRuleAllOfCondition,
  "ActivityLogAlertAllOfCondition",
  "java"
);
@@clientName(
  ActivityLogAlertsApi.AlertRuleAnyOfOrLeafCondition,
  "ActivityLogAlertLeafCondition",
  "java"
);

// MetricUnit - rename to Unit
@@clientName(MetricsApi.MetricUnit, "Unit", "java");

// PrivateEndpointConnection - PrivateLinkScopes is canonical; rename Azure common type duplicate
@@clientName(
  Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "PrivateEndpointConnectionAutoGenerated",
  "java"
);

// ErrorResponse/ErrorDetail - Common/main.tsp is canonical; rename Azure common type duplicates
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ErrorResponseAutoGenerated",
  "java,python,csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ErrorDetailAutoGenerated",
  "java,python,csharp"
);

// Response.resourceregion - rename to resourceRegion for Java camelCase
@@clientName(MetricsApi.Response.resourceregion, "resourceRegion", "java");

// Response.interval - use Duration type
@@alternateType(MetricsApi.Response.interval, duration, "java");

// Request.interval - use Duration type
@@alternateType(MetricsApi.IntervalQueryParameter.interval, duration, "java");

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular metric.
 */
model MetricSettings {
  /**
   * the timegrain of the metric in ISO8601 format.
   */
  timeGrain?: duration;

  /**
   * Name of a Diagnostic Metric category for a resource type this setting is applied to. To obtain the list of Diagnostic metric categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * a value indicating whether this category is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this category.
   */
  retentionPolicy?: Microsoft.Common.RetentionPolicy;
}
@@clientName(MetricSettings.enabled, "IsEnabled", "csharp");

@@alternateType(
  ServiceDiagnosticsSettingsApi.MetricSettings,
  MetricSettings,
  "csharp,java,python"
);

/**
 * Part of MultiTenantDiagnosticSettings. Specifies the settings for a particular log.
 */
model LogSettings {
  /**
   * Name of a Diagnostic Log category for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  category?: string;

  /**
   * Name of a Diagnostic Log category group for a resource type this setting is applied to. To obtain the list of Diagnostic Log categories for a resource, first perform a GET diagnostic settings operation.
   */
  categoryGroup?: string;

  /**
   * a value indicating whether this log is enabled.
   */
  enabled: boolean;

  /**
   * the retention policy for this log.
   */
  retentionPolicy?: Microsoft.Common.RetentionPolicy;
}
@@clientName(LogSettings.enabled, "IsEnabled", "csharp");

@@alternateType(
  ServiceDiagnosticsSettingsApi.LogSettings,
  LogSettings,
  "csharp,java,python"
);

@@clientLocation(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.getNSP,
  "NspScheduledQueryRule",
  "java"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.listNSP,
  "NspScheduledQueryRule",
  "java"
);
@@clientLocation(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.reconcileNSP,
  "NspScheduledQueryRule",
  "java"
);
@@clientName(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.getNSP,
  "GetNetworkSecurityPerimeterConfiguration",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.listNSP,
  "GetNetworkSecurityPerimeterConfigurations",
  "csharp"
);
@@clientName(
  NetworkSecurityPerimeterApi.ScheduledQueryRule.reconcileNSP,
  "ReconcileNetworkSecurityPerimeterConfiguration",
  "csharp"
);

@@alternateType(AutoscaleNotification.operation, "Scale", "java");

@@clientName(MetricsApi.MetricValue.timeStamp, "timestamp", "java");
@@clientName(AutoScaleApi.PredictiveValue.timeStamp, "timestamp", "java");
@@clientName(
  MetricAlertApi.MetricAlertAction.webHookProperties,
  "webhookProperties",
  "java"
);

@@clientName(AlertSeverity.`0`, "Zero", "csharp,go,javascript");
@@clientName(AlertSeverity.`1`, "One", "csharp,go,javascript");
@@clientName(AlertSeverity.`2`, "Two", "csharp,go,javascript");
@@clientName(AlertSeverity.`3`, "Three", "csharp,go,javascript");
@@clientName(AlertSeverity.`4`, "Four", "csharp,go,javascript");

@@alternateType(AutoscaleNotification.operation, "Scale", "go");

/**
 * we add this model  in order to replace subscriptions model in CommonTypes with this model via alternateType decorator
 */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: Azure.Core.armResourceIdentifier;
}
@@clientName(
  AccessRulePropertiesSubscriptionsItem,
  "MonitorNetworkSecurityPerimeterConfigurationAccessRuleSubscription",
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  AccessRulePropertiesSubscriptionsItem[],
  "csharp,go"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "ArmErrorDetail",
  "javascript"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "javascript"
);

@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`ISO 8601`,
  "ISO8601",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`YYYY-MM-DD HH:MM:SS`,
  "YYYY_MM_DD_HH_MM_SS",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`M/D/YYYY HH:MM:SS AM/PM`,
  "M_D_YYYY_HH_MM_SS_AM_PM",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`Mon DD, YYYY HH:MM:SS`,
  "MON_DD_YYYY_HH_MM_SS",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`yyMMdd HH:mm:ss`,
  "YY_M_MDD_HH_MM_SS",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`ddMMyy HH:mm:ss`,
  "DD_M_MYY_HH_MM_SS",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`MMM d hh:mm:ss`,
  "MMM_D_HH_MM_SS",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`dd/MMM/yyyy:HH:mm:ss zzz`,
  "DD_MMM_YYYY_HH_MM_SS_ZZZ",
  "python"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`YYYY-MM-DD HH:MM:SS`,
  "YyyyMmDdHhMmSs",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`M/D/YYYY HH:MM:SS AM/PM`,
  "MDYyyyHhMmSsAMPM",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`Mon DD, YYYY HH:MM:SS`,
  "MonDdYyyyHhMmSs",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`yyMMdd HH:mm:ss`,
  "YyMMddHhMmSs",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`ddMMyy HH:mm:ss`,
  "DdMMyyHhMmSs",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`MMM d hh:mm:ss`,
  "MmmDHhMmSs",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`dd/MMM/yyyy:HH:mm:ss zzz`,
  "DdMmmYyyyHhMmSsZzz",
  "csharp"
);
@@clientName(
  DataCollectionApi.KnownLogFileTextSettingsRecordStartTimestampFormat.`yyyy-MM-ddTHH:mm:ssK`,
  "YyyyMmDdTHHMmSsK",
  "csharp"
);
@@clientName(AlertSeverity.`0`, "ZERO", "python");
@@clientName(AlertSeverity.`1`, "ONE", "python");
@@clientName(AlertSeverity.`2`, "TWO", "python");
@@clientName(AlertSeverity.`3`, "THREE", "python");
@@clientName(AlertSeverity.`4`, "FOUR", "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op PrivateLinkScopeOperationStatusGetCustomized(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  /** The operation Id. */
  @path
  asyncOperationId: string,

  ...ResourceGroupParameter,
):
  | Azure.ResourceManager.ArmResponse<OperationStatus>
  | Azure.ResourceManager.ErrorResponse;

@@override(
  PrivateLinkScopeOperationStatusOperationGroup.get,
  PrivateLinkScopeOperationStatusGetCustomized,
  "python"
);

@@clientName(
  ActionGroupsApi.ActionGroup,
  "ActionGroupResourceProperties",
  "python"
);
@@clientName(
  ActivityLogAlertsApi.ActivityLogAlertActionGroup,
  "ActionGroup",
  "python"
);
@@clientName(
  Microsoft.Common.CommonErrorResponse,
  "ErrorResponseCommon",
  "python"
);

import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Dynatrace.Observability;

@@clientName(EnvironmentInfo.landingURL, "landingUrl", "java");

// Removing below operations as these are not currently supported in the backend
@@scope(CreationSupportedOperationGroup.list, "!csharp");
@@scope(CreationSupportedOperationGroup.get, "!csharp");
@@scope(MonitorsOperationGroup.getAllConnectedResourcesCount, "!csharp");

@@clientName(DynatraceSingleSignOnResource, "DynatraceSingleSignOn", "csharp");
@@clientName(ProvisioningState, "DynatraceProvisioningState", "csharp");
@@clientName(SingleSignOnStates, "DynatraceSingleSignOnState", "csharp");
@@clientName(MonitorResource, "DynatraceMonitor", "csharp");
@@clientName(MonitorProperties, "DynatraceMonitorProperties", "csharp");
@@clientName(MonitorResourceUpdate, "DynatraceMonitorPatch", "csharp");
@@clientName(AppServiceInfo,
  "DynatraceOneAgentEnabledAppServiceInfo",
  "csharp"
);
@@alternateType(AppServiceInfo.resourceId, armResourceIdentifier, "csharp");
@@clientName(VMInfo, "DynatraceMonitorVmInfo", "csharp");
@@alternateType(VMInfo.resourceId, armResourceIdentifier, "csharp");
@@clientName(SSODetailsResponse, "DynatraceSsoDetailsResult", "csharp");
@@alternateType(SSODetailsResponse.metadataUrl, url, "csharp");
@@alternateType(SSODetailsResponse.singleSignOnUrl, url, "csharp");
@@clientName(SSODetailsRequest, "DynatraceSsoDetailsContent", "csharp");
@@clientName(LinkableEnvironmentResponse,
  "LinkableEnvironmentResult",
  "csharp"
);
@@alternateType(LinkableEnvironmentRequest.region, azureLocation, "csharp");
@@clientName(MonitoredResource, "DynatraceMonitoredResourceDetails", "csharp");
@@alternateType(MonitoredResource.id, armResourceIdentifier, "csharp");
@@clientName(MonitoredResource.sendingMetrics,
  "SendingMetricsStatus",
  "csharp"
);
@@clientName(MonitoredResource.sendingLogs, "SendingLogsStatus", "csharp");
@@clientName(VMExtensionPayload, "DynatraceVmExtensionPayload", "csharp");
@@clientName(MarketplaceSubscriptionStatus,
  "DynatraceMonitorMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(MonitoringStatus, "DynatraceMonitoringStatus", "csharp");
@@clientName(PlanData, "DynatraceBillingPlanInfo", "csharp");
@@clientName(UserInfo, "DynatraceMonitorUserInfo", "csharp");
@@clientName(TagRule, "DynatraceTagRule", "csharp");
@@clientName(MonitoringTagRulesProperties,
  "DynatraceTagRuleProperties",
  "csharp"
);
@@clientName(LogRules, "DynatraceMonitorResourceLogRules", "csharp");
@@clientName(MetricRules, "DynatraceMonitorResourceMetricRules", "csharp");
@@clientName(FilteringTag, "DynatraceMonitorResourceFilteringTag", "csharp");
@@clientName(TagAction, "DynatraceMonitorResourceTagAction", "csharp");
@@clientName(AccountInfo, "DynatraceAccountInfo", "csharp");
@@clientName(AutoUpdateSetting, "DynatraceOneAgentAutoUpdateSetting", "csharp");
@@clientName(AutoUpdateSetting.DISABLED, "Disabled", "csharp");
@@clientName(AutoUpdateSetting.ENABLED, "Enabled", "csharp");
@@clientName(AvailabilityState, "DynatraceOneAgentAvailabilityState", "csharp");
@@clientName(AvailabilityState.CRASHED, "Crashed", "csharp");
@@clientName(AvailabilityState.LOST, "Lost", "csharp");
@@clientName(AvailabilityState.MONITORED, "Monitored", "csharp");
@@clientName(AvailabilityState.PRE_MONITORED, "PreMonitored", "csharp");
@@clientName(AvailabilityState.SHUTDOWN, "Shutdown", "csharp");
@@clientName(AvailabilityState.UNEXPECTED_SHUTDOWN,
  "UnexpectedShutdown",
  "csharp"
);
@@clientName(AvailabilityState.UNKNOWN, "Unknown", "csharp");
@@clientName(AvailabilityState.UNMONITORED, "Unmonitored", "csharp");
@@clientName(LogModule, "DynatraceLogModuleState", "csharp");
@@clientName(LogModule.ENABLED, "Enabled", "csharp");
@@clientName(LogModule.DISABLED, "Disabled", "csharp");
@@clientName(MonitoringType, "DynatraceOneAgentMonitoringType", "csharp");
@@clientName(MonitoringType.CLOUD_INFRASTRUCTURE,
  "CloudInfrastructure",
  "csharp"
);
@@clientName(MonitoringType.FULL_STACK, "FullStack", "csharp");
@@clientName(MonitoringType.DISCOVERY, "Discovery", "csharp");
@@clientName(UpdateStatus, "DynatraceOneAgentUpdateStatus", "csharp");
@@clientName(UpdateStatus.INCOMPATIBLE, "Incompatible", "csharp");
@@clientName(UpdateStatus.OUTDATED, "Outdated", "csharp");
@@clientName(UpdateStatus.SCHEDULED, "Scheduled", "csharp");
@@clientName(UpdateStatus.SUPPRESSED, "Suppressed", "csharp");
@@clientName(UpdateStatus.UNKNOWN, "Unknown", "csharp");
@@clientName(UpdateStatus.UP2DATE, "UpToDate", "csharp");
@@clientName(UpdateStatus.UPDATE_IN_PROGRESS, "UpdateInProgress", "csharp");
@@clientName(UpdateStatus.UPDATE_PENDING, "UpdatePending", "csharp");
@@clientName(UpdateStatus.UPDATE_PROBLEM, "UpdateProblem", "csharp");
@@clientName(EnvironmentInfo, "DynatraceEnvironmentInfo", "csharp");
@@clientName(EnvironmentInfo.landingURL, "LandingUri", "csharp");
@@alternateType(EnvironmentInfo.landingURL, url, "csharp");
@@alternateType(EnvironmentInfo.logsIngestionEndpoint, url, "csharp");
@@clientName(SSOStatus, "DynatraceSsoStatus", "csharp");
@@clientName(SendAadLogsStatus, "AadLogsSendingStatus", "csharp");
@@clientName(SendSubscriptionLogsStatus,
  "SubscriptionLogsSendingStatus",
  "csharp"
);
@@clientName(SendActivityLogsStatus, "ActivityLogsSendingStatus", "csharp");
@@clientName(SendingLogsStatus, "LogsSendingStatus", "csharp");
@@clientName(SendingMetricsStatus, "MetricsSendingStatus", "csharp");
@@clientName(MetricsStatusResponse, "DynatraceMetricsStatusResult", "csharp");
@@alternateType(MetricsStatusResponse.azureResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(LogStatusRequest, "DynatraceMonitoredResourceContent", "csharp");
@@clientName(MarketplaceSaaSResourceDetailsResponse,
  "MarketplaceSaaSResourceDetailsResult",
  "csharp"
);
@@alternateType(MarketplaceSaaSResourceDetailsResponse.marketplaceSaaSResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ConnectedResourcesCountResponse,
  "ConnectedResourcesCountResult",
  "csharp"
);
@@clientName(Action, "DynatraceAgentAction", "csharp");
@@clientName(CreateResourceSupportedProperties.creationSupported,
  "IsCreationSupported",
  "csharp"
);
@@clientName(MonitoredSubscription,
  "DynatraceMonitoredSubscriptionStatus",
  "csharp"
);
@@clientName(Status, "DynatraceMonitoringState", "csharp");
@@clientName(SubscriptionList,
  "DynatraceMonitoredSubscriptionProperties",
  "csharp"
);
@@clientName(SubscriptionListOperation,
  "DynatraceMonitoredSubscriptionOperation",
  "csharp"
);
@@clientName(MonitoredSubscriptionProperties,
  "DynatraceMonitoredSubscription",
  "csharp"
);
@@clientName(UpgradePlanRequest, "DynatraceUpgradePlanContent", "csharp");
@@alternateType(DynatraceSingleSignOnProperties.enterpriseAppId,
  uuid,
  "csharp"
);
@@alternateType(DynatraceSingleSignOnProperties.singleSignOnUrl, url, "csharp");
@@alternateType(MarketplaceSubscriptionIdRequest.marketplaceSubscriptionId,
  uuid,
  "csharp"
);
@@alternateType(MonitoredSubscription.subscriptionId, uuid, "csharp");
@@clientName(MonitorsOperationGroup.getMarketplaceSaaSResourceDetails,
  "GetMarketplaceSaaSResourceDetailsResult",
  "csharp"
);
@@clientName(LinkableEnvironmentRequest,
  "LinkableEnvironmentContent",
  "csharp"
);
@@alternateType(LinkableEnvironmentRequest.tenantId, uuid, "csharp");
@@clientName(ManageAgentInstallationRequest,
  "ManageAgentInstallationContent",
  "csharp"
);
@@clientName(MetricStatusRequest, "DynatraceMetricStatusContent", "csharp");
@@clientName(MarketplaceSaaSResourceDetailsRequest,
  "MarketplaceSaaSResourceDetailsContent",
  "csharp"
);
@@alternateType(MarketplaceSaaSResourceDetailsRequest.tenantId, uuid, "csharp");
@@clientName(MonitorResources.getMetricStatus::parameters.body,
  "content",
  "csharp"
);
@@clientName(MonitorResources.listMonitoredResources::parameters.body,
  "content",
  "csharp"
);
@@clientName(MonitorResources.getVMHostPayload, "getVmHostPayload", "csharp");
@@clientName(MonitorResources.getSSODetails, "getSsoDetails", "csharp");
@@clientName(MonitorResources.getSSODetails::parameters.body,
  "content",
  "csharp"
);
@@clientName(ManageAgentList, "DynatraceManageAgentDetails", "csharp");
@@alternateType(ManageAgentList.id, armResourceIdentifier, "csharp");
@@clientName(LiftrResourceCategories, "LiftrResourceCategory", "csharp");
@@clientName(VMHostsListResponse, "VmHostsListResult", "csharp");

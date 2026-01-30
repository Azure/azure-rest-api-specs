import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Datadog;

// csharp configurations
@@clientName(Microsoft.Datadog, "MicrosoftDatadogClient", "javascript");
@@clientName(BillingInfoResponse, "DatadogBillingInfoResult", "csharp");
@@clientName(CreateResourceSupportedResponse,
  "DatadogSubscriptionStatusResult",
  "csharp"
);
@@clientName(AgentRules, "DatadogMonitorAgentRules", "csharp");
@@clientName(AgentRules.enableAgentMonitoring,
  "IsAgentMonitoringEnabled",
  "csharp"
);
@@clientName(CreateResourceSupportedProperties,
  "DatadogSubscriptionStatusProperties",
  "csharp"
);
@@clientName(CreateResourceSupportedProperties.creationSupported,
  "IsCreationSupported",
  "csharp"
);
// @@clientName(DatadogAgreementResource, "DatadogAgreement", "csharp");
@@clientName(DatadogAgreementProperties.accepted, "IsAccepted", "csharp");
@@clientName(DatadogMonitorResource, "DatadogMonitor", "csharp");
@@clientName(DatadogOrganizationProperties.cspm, "IsCspm", "csharp");
@@clientName(DatadogOrganizationProperties.resourceCollection,
  "IsResourceCollection",
  "csharp"
);
@@clientName(DatadogSingleSignOnResource, "DatadogSingleSignOn", "csharp");
@@clientName(FilteringTag, "DatadogMonitorFilteringTag", "csharp");
@@clientName(LiftrResourceCategories, "DatadogLiftrResourceCategory", "csharp");
@@clientName(LinkedResource, "DatadogLinkedResourceResult", "csharp");
@@clientName(LogRules, "DatadogMonitorLogRules", "csharp");
@@clientName(LogRules.sendAadLogs, "IsAadLogsSent", "csharp");
@@clientName(LogRules.sendResourceLogs, "IsResourceLogsSent", "csharp");
@@clientName(LogRules.sendSubscriptionLogs, "IsSubscriptionLogsSent", "csharp");
@@clientName(MarketplaceSaaSInfo.subscribed, "IsSubscribed", "csharp");
@@clientName(MetricRules, "DatadogMonitorMetricRules", "csharp");
@@clientName(MonitoredResource, "DatadogMonitoredResourceResult", "csharp");
@@clientName(MonitoredResource.sendingLogs, "IsSendingLogsEnabled", "csharp");
@@clientName(MonitoredResource.sendingMetrics,
  "IsSendingMetricsEnabled",
  "csharp"
);
@@clientName(MonitoredSubscription,
  "DatadogMonitoredSubscriptionItem",
  "csharp"
);
@@clientName(MonitoredSubscriptionProperties,
  "DatadogMonitoredSubscription",
  "csharp"
);
@@clientName(MonitoringStatus, "DatadogMonitoringStatus", "csharp");
@@clientName(MonitoringTagRules, "DataMonitoringTagRule", "csharp");
@@clientName(MonitoringTagRulesProperties,
  "MonitoringTagRuleProperties",
  "csharp"
);
@@clientName(MonitoringTagRulesProperties.automuting,
  "IsAutomutingEnabled",
  "csharp"
);
@@clientName(MonitoringTagRulesProperties.customMetrics,
  "IsCustomMetricsEnabled",
  "csharp"
);
@@clientName(MonitorProperties, "DatadogMonitorProperties", "csharp");
@@clientName(MonitorUpdateProperties,
  "DatadogMonitorResourcePatchProperties",
  "csharp"
);
@@clientName(MonitorUpdateProperties.cspm, "IsCspm", "csharp");
@@clientName(MonitorUpdateProperties.resourceCollection,
  "IsResourceCollection",
  "csharp"
);
@@clientName(Operation, "DatadogOperation", "csharp");
@@clientName(ProvisioningState, "DatadogProvisioningState", "csharp");
@@clientName(ResourceSku, "DatadogSku", "csharp");
@@clientName(ResubscribeProperties, "ResubscribeOrganizationContent", "csharp");
@@clientName(SingleSignOnStates, "DatadogSingleSignOnState", "csharp");
@@clientName(Status, "DatadogMonitorStatus", "csharp");
@@clientName(SubscriptionList, "DatadogSubscriptionProperties", "csharp");
@@clientName(TagAction, "DatadogMonitorTagAction", "csharp");
@@clientName(UserInfo, "DatadogUserInfo", "csharp");
@@clientName(CreationSupportedOperationGroup.list,
  "GetSubscriptionStatuses",
  "csharp"
);
@@clientName(CreationSupportedOperationGroup.get,
  "GetSubscriptionStatus",
  "csharp"
);
@@clientName(DatadogMonitorResources.billingInfoGet,
  "GetBillingInfo",
  "csharp"
);
@@clientName(DatadogMonitorResourceUpdateParameters,
  "DatadogMonitorPatch",
  "csharp"
);
@@clientName(SreAgentConfigurationListResponse,
  "DatadogSreAgentConfigurationListResult",
  "csharp"
);
@@clientName(SreAgentConnectorRequest,
  "DatadogSreAgentConnectorContent",
  "csharp"
);
@@clientName(MarketplaceAgreementsOperationGroup.createOrUpdate,
  "CreateOrUpdateMarketplaceAgreement",
  "csharp"
);
@@clientName(MarketplaceAgreementsOperationGroup.list,
  "GetMarketplaceAgreements",
  "csharp"
);
@@clientName(DatadogMonitorResources.resubscribe,
  "ResubscribeOrganization",
  "csharp"
);
@@alternateType(MonitoredResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LinkedResource.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(LinkedResource.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PartnerBillingEntity.partnerEntityUri, url, "csharp");
@@alternateType(DatadogSingleSignOnProperties.singleSignOnUrl, url, "csharp");
@@alternateType(DatadogOrganizationProperties.redirectUri, url, "csharp");
@@alternateType(DatadogMonitorResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(DatadogAgreementResource, DatadogAgreement, "csharp");

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DatadogAgreement extends Azure.ResourceManager.CommonTypes.Resource {
  ...OmitProperties<
    DatadogAgreementResource,
    "id" | "name" | "type" | "systemData"
  >;
}

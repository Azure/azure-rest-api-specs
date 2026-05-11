import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using NewRelic.Observability;

@@clientName(NewRelic.Observability,
  "NewRelicObservabilityMgmtClient",
  "python"
);

@@clientName(NewRelic.Observability.NewRelicAccountProperties,
  "AccountPropertiesForNewRelic",
  "go"
);

@@clientName(NewRelic.Observability.MonitoredSubscriptions.createOrUpdate,
  "createorUpdate",
  "go"
);

// ===== C# operation renames =====
@@clientName(NewRelicMonitorResources.billingInfoGet,
  "GetBillingInfo",
  "csharp"
);
@@clientName(AccountsOperationGroup.list, "GetNewRelicAccounts", "csharp");
@@clientName(OrganizationsOperationGroup.list,
  "GetNewRelicOrganizations",
  "csharp"
);
@@clientName(PlansOperationGroup.list, "GetNewRelicPlans", "csharp");

// ===== C# resource type renames =====
@@clientName(MonitoredSubscriptionProperties,
  "NewRelicMonitoredSubscription",
  "csharp"
);
@@clientName(TagRule, "NewRelicObservabilityTagRule", "csharp");

// ===== C# model renames (RP prefix) =====
@@clientName(AccountInfo, "NewRelicObservabilityAccountInfo", "csharp");
@@clientName(AppServiceInfo, "NewRelicObservabilityAppServiceInfo", "csharp");
@@clientName(FilteringTag, "NewRelicObservabilityFilteringTag", "csharp");
@@clientName(LogRules, "NewRelicObservabilityLogRules", "csharp");
@@clientName(MetricRules, "NewRelicObservabilityMetricRules", "csharp");
@@clientName(OrganizationInfo,
  "NewRelicObservabilityOrganizationInfo",
  "csharp"
);
@@clientName(UserInfo, "NewRelicObservabilityUserInfo", "csharp");
@@clientName(VMExtensionPayload,
  "NewRelicObservabilityVmExtensionPayload",
  "csharp"
);
@@clientName(VMInfo, "NewRelicObservabilityVmInfo", "csharp");

// ===== C# enum/union renames (RP prefix) =====
@@clientName(AccountCreationSource,
  "NewRelicObservabilityAccountCreationSource",
  "csharp"
);
@@clientName(BillingSource, "NewRelicObservabilityBillingSource", "csharp");
@@clientName(MarketplaceSubscriptionStatus,
  "NewRelicObservabilityMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(MonitoringStatus,
  "NewRelicObservabilityMonitoringStatus",
  "csharp"
);
@@clientName(OrgCreationSource,
  "NewRelicObservabilityOrgCreationSource",
  "csharp"
);
@@clientName(SendAadLogsStatus,
  "NewRelicObservabilitySendAadLogsStatus",
  "csharp"
);
@@clientName(SendActivityLogsStatus,
  "NewRelicObservabilitySendActivityLogsStatus",
  "csharp"
);
@@clientName(SendingLogsStatus,
  "NewRelicObservabilitySendingLogsStatus",
  "csharp"
);
@@clientName(SendingMetricsStatus,
  "NewRelicObservabilitySendingMetricsStatus",
  "csharp"
);
@@clientName(SendMetricsStatus,
  "NewRelicObservabilitySendMetricsStatus",
  "csharp"
);
@@clientName(SendSubscriptionLogsStatus,
  "NewRelicObservabilitySendSubscriptionLogsStatus",
  "csharp"
);
@@clientName(TagAction, "NewRelicObservabilityTagAction", "csharp");
@@clientName(UsageType, "NewRelicObservabilityUsageType", "csharp");

// ===== C# enum value renames =====
@@clientName(MonitoringStatus.Enabled, "IsEnabled", "csharp");
@@clientName(MonitoringStatus.Disabled, "IsDisabled", "csharp");
@@clientName(SendAadLogsStatus.Enabled, "IsEnabled", "csharp");
@@clientName(SendAadLogsStatus.Disabled, "IsDisabled", "csharp");
@@clientName(SendActivityLogsStatus.Enabled, "IsEnabled", "csharp");
@@clientName(SendActivityLogsStatus.Disabled, "IsDisabled", "csharp");
@@clientName(SendingLogsStatus.Enabled, "IsEnabled", "csharp");
@@clientName(SendingLogsStatus.Disabled, "IsDisabled", "csharp");
@@clientName(SendingMetricsStatus.Enabled, "IsEnabled", "csharp");
@@clientName(SendingMetricsStatus.Disabled, "IsDisabled", "csharp");
@@clientName(SendSubscriptionLogsStatus.Enabled, "IsEnabled", "csharp");
@@clientName(SendSubscriptionLogsStatus.Disabled, "IsDisabled", "csharp");

// ===== C# model renames (rename-mapping equivalents) =====
@@clientName(ActivateSaaSParameterRequest,
  "ActivateSaaSParameterContent",
  "csharp"
);
@@clientName(AppServicesGetRequest, "NewRelicAppServicesGetContent", "csharp");
@@clientName(BillingInfoResponse, "NewRelicBillingInfoResult", "csharp");
@@clientName(ConnectedPartnerResourcesListFormat,
  "NewRelicConnectedPartnerResourceInfo",
  "csharp"
);
@@clientName(ConnectedPartnerResourceProperties,
  "NewRelicConnectedPartnerResourceProperties",
  "csharp"
);
@@clientName(HostsGetRequest, "NewRelicHostsGetContent", "csharp");
@@clientName(LatestLinkedSaaSResponse,
  "NewRelicObservabilityLatestLinkedSaaSResult",
  "csharp"
);
@@clientName(LiftrResourceCategories,
  "NewRelicLiftrResourceCategory",
  "csharp"
);
@@clientName(MetricsRequest, "NewRelicMetricsContent", "csharp");
@@clientName(MetricsStatusRequest, "NewRelicMetricsStatusContent", "csharp");
@@clientName(MetricsStatusResponse, "NewRelicMetricsStatusResult", "csharp");
@@clientName(MonitoredResource, "NewRelicResourceMonitorResult", "csharp");
@@clientName(MonitoredSubscription,
  "NewRelicMonitoredSubscriptionInfo",
  "csharp"
);
@@clientName(MonitoringTagRulesProperties,
  "NewRelicMonitoringTagRules",
  "csharp"
);
@@clientName(ProvisioningState, "NewRelicProvisioningState", "csharp");
@@clientName(SingleSignOnStates, "NewRelicSingleSignOnState", "csharp");
@@clientName(Status, "NewRelicMonitoringStatus", "csharp");
@@clientName(SwitchBillingRequest, "NewRelicSwitchBillingContent", "csharp");
@@clientName(ConfigurationName,
  "MonitoredSubscriptionConfigurationName",
  "csharp"
);
@@clientName(PatchOperation, "MonitoredSubscriptionPatchOperation", "csharp");
@@clientName(SubscriptionList,
  "NewRelicMonitoredSubscriptionProperties",
  "csharp"
);
@@clientName(SaaSResourceDetailsResponse,
  "NewRelicObservabilitySaaSResourceDetailsResult",
  "csharp"
);
@@clientName(SaaSData, "NewRelicObservabilitySaaSInfo", "csharp");
@@clientName(AccountResource, "NewRelicAccountResourceData", "csharp");
@@clientName(OrganizationResource,
  "NewRelicOrganizationResourceData",
  "csharp"
);
@@clientName(PlanDataResource, "NewRelicPlanData", "csharp");
@@clientName(PlanData, "NewRelicPlanDetails", "csharp");
@@clientName(PlanData.billingCycle, "NewRelicPlanBillingCycle", "csharp");

// ===== C# type overrides for ARM Common Types v3 =====
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ===== C# alternateType for ResourceIdentifier properties =====
@@alternateType(AppServiceInfo.azureResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SwitchBillingRequest.azureResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VMInfo.vmId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(MonitoredResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AppServicesGetRequest.azureResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(HostsGetRequest.vmIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);

// ===== C# alternateType for AzureLocation properties =====
@@alternateType(AccountProperties.region, Azure.Core.azureLocation, "csharp");
@@alternateType(AccountInfo.region, Azure.Core.azureLocation, "csharp");
@@alternateType(ConnectedPartnerResourceProperties.location,
  Azure.Core.azureLocation,
  "csharp"
);

// ===== C# alternateType for Uri properties =====
@@alternateType(NewRelicSingleSignOnProperties.singleSignOnUrl, url, "csharp");
@@clientName(NewRelicSingleSignOnProperties.singleSignOnUrl,
  "SingleSignOnUri",
  "csharp"
);

// ===== C# enum value renames (casing: LIFTR->Liftr, NEWRELIC->Newrelic, etc.) =====
@@clientName(AccountCreationSource.LIFTR, "Liftr", "csharp");
@@clientName(AccountCreationSource.NEWRELIC, "Newrelic", "csharp");
@@clientName(BillingSource.AZURE, "Azure", "csharp");
@@clientName(BillingSource.NEWRELIC, "Newrelic", "csharp");
@@clientName(OrgCreationSource.LIFTR, "Liftr", "csharp");
@@clientName(OrgCreationSource.NEWRELIC, "Newrelic", "csharp");
@@clientName(UsageType.PAYG, "Payg", "csharp");
@@clientName(UsageType.COMMITTED, "Committed", "csharp");

// ===== C# operation renames for ConnectedPartnerResources =====
@@clientName(NewRelicMonitorResources.list,
  "GetConnectedPartnerResources",
  "csharp"
);

// ===== C# alternateType for operation parameters =====
@@alternateType(AccountsOperationGroup.list::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(OrganizationsOperationGroup.list::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

// ===== C# LinkedResource → SubResource replacement =====
namespace Azure.ResourceManager.Models {
  model SubResource {
    id?: armResourceIdentifier;
  }
}

@@alternateType(LinkedResourceListResponse.value,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);

// ===== C# flatten properties for backward compatibility =====
// These models were previously flattened in the old AutoRest SDK.
// Using @flattenProperty to preserve top-level property access.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for C# SDK backward compatibility"
@@flattenProperty(AccountResource.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for C# SDK backward compatibility"
@@flattenProperty(OrganizationResource.properties, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for C# SDK backward compatibility"
@@flattenProperty(PlanDataResource.properties, "csharp");

// ===== C# usage decorators for property types that need setters =====
// The flattened properties need setters for backward compatibility.
// Adding input usage generates setters on the inner property types.
@@usage(AccountProperties, Usage.input | Usage.output, "csharp");
@@usage(OrganizationProperties, Usage.input | Usage.output, "csharp");
@@usage(PlanDataProperties, Usage.input | Usage.output, "csharp");

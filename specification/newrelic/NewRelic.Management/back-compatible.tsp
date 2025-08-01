import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NewRelic.Observability;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccountResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OrganizationResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PlanDataResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NewRelicMonitorResourceUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagRuleUpdate.properties);

@@clientLocation(NewRelicMonitorResources.get, "Monitors");
@@clientLocation(NewRelicMonitorResources.createOrUpdate, "Monitors");
@@clientLocation(NewRelicMonitorResources.update, "Monitors");
@@clientLocation(NewRelicMonitorResources.delete, "Monitors");
@@clientLocation(NewRelicMonitorResources.listByResourceGroup, "Monitors");
@@clientLocation(NewRelicMonitorResources.listBySubscription, "Monitors");
@@clientLocation(NewRelicMonitorResources.getMetricRules, "Monitors");
@@clientName(NewRelicMonitorResources.getMetricRules::parameters.body,
  "request"
);
@@clientLocation(NewRelicMonitorResources.getMetricStatus, "Monitors");
@@clientName(NewRelicMonitorResources.getMetricStatus::parameters.body,
  "request"
);
@@clientLocation(NewRelicMonitorResources.listAppServices, "Monitors");
@@clientName(NewRelicMonitorResources.listAppServices::parameters.body,
  "request"
);
@@clientLocation(NewRelicMonitorResources.switchBilling, "Monitors");
@@clientName(NewRelicMonitorResources.switchBilling::parameters.body,
  "request"
);
@@clientLocation(NewRelicMonitorResources.listHosts, "Monitors");
@@clientName(NewRelicMonitorResources.listHosts::parameters.body, "request");
@@clientLocation(NewRelicMonitorResources.refreshIngestionKey, "Monitors");
@@clientLocation(NewRelicMonitorResources.listMonitoredResources, "Monitors");
@@clientLocation(NewRelicMonitorResources.listLinkedResources, "Monitors");
@@clientLocation(NewRelicMonitorResources.vmHostPayload, "Monitors");
@@clientLocation(NewRelicMonitorResources.latestLinkedSaaS, "Monitors");
@@clientLocation(NewRelicMonitorResources.linkSaaS, "Monitors");
@@clientLocation(NewRelicMonitorResources.resubscribe, "Monitors");
@@clientLocation(NewRelicMonitorResources.billingInfoGet, "BillingInfo");
@@clientName(NewRelicMonitorResources.billingInfoGet, "Get");
@@clientLocation(NewRelicMonitorResources.list, "ConnectedPartnerResources");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NewRelicMonitorResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagRule.properties);

@@clientName(MonitoredSubscriptions.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientLocation(AccountsOperationGroup.list, "Accounts");

@@clientLocation(OrganizationsOperationGroup.list, "Organizations");

@@clientLocation(PlansOperationGroup.list, "Plans");

@@clientLocation(SaaSOperationGroup.activateResource, "SaaS");

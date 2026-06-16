import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NewRelic.Observability;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AccountResource.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrganizationResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PlanDataResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NewRelicMonitorResourceUpdate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TagRuleUpdate.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NewRelicMonitorResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TagRule.properties);

@@clientName(MonitoredSubscriptions.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientLocation(AccountsOperationGroup.list, "Accounts");

@@clientLocation(OrganizationsOperationGroup.list, "Organizations");

@@clientLocation(PlansOperationGroup.list, "Plans");

@@clientLocation(SaaSOperationGroup.activateResource, "SaaS");
@@clientName(SaaSOperationGroup.activateResource::parameters.body, "request");

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Dynatrace.Observability;

@@clientName(MonitoredSubscriptions.createOrUpdate::parameters.resource,
  "body"
);
@@clientName(MonitoredSubscriptions.update::parameters.properties, "body");

@@clientLocation(MonitorResources.get, "Monitors");
@@clientLocation(MonitorResources.createOrUpdate, "Monitors");
@@clientLocation(MonitorResources.update, "Monitors");
@@clientName(MonitorResources.update::parameters.properties, "resource");
@@clientLocation(MonitorResources.delete, "Monitors");
@@clientLocation(MonitorResources.listByResourceGroup, "Monitors");
@@clientLocation(MonitorResources.listBySubscriptionId, "Monitors");
@@clientLocation(MonitorResources.listMonitoredResources, "Monitors");
@@clientName(MonitorResources.listMonitoredResources::parameters.body,
  "request"
);
@@clientLocation(MonitorResources.getVMHostPayload, "Monitors");
@@clientLocation(MonitorResources.manageAgentInstallation, "Monitors");
@@clientName(MonitorResources.manageAgentInstallation::parameters.body,
  "request"
);
@@clientLocation(MonitorResources.listHosts, "Monitors");
@@clientLocation(MonitorResources.getMetricStatus, "Monitors");
@@clientName(MonitorResources.getMetricStatus::parameters.body, "request");
@@clientLocation(MonitorResources.listAppServices, "Monitors");
@@clientLocation(MonitorResources.upgradePlan, "Monitors");
@@clientName(MonitorResources.upgradePlan::parameters.body, "request");
@@clientLocation(MonitorResources.getSSODetails, "Monitors");
@@clientName(MonitorResources.getSSODetails::parameters.body, "request");
@@clientLocation(MonitorResources.listLinkableEnvironments, "Monitors");
@@clientName(MonitorResources.listLinkableEnvironments::parameters.body,
  "request"
);
#suppress "deprecated" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MonitorResource.properties);

#suppress "deprecated" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TagRule.properties);

@@clientLocation(DynatraceSingleSignOnResources.get, "SingleSignOn");
@@clientLocation(DynatraceSingleSignOnResources.createOrUpdate, "SingleSignOn");
@@clientLocation(DynatraceSingleSignOnResources.list, "SingleSignOn");
#suppress "deprecated" "FixME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DynatraceSingleSignOnResource.properties
);

@@clientLocation(MonitorsOperationGroup.getAllConnectedResourcesCount,
  "Monitors"
);
@@clientLocation(MonitorsOperationGroup.getMarketplaceSaaSResourceDetails,
  "Monitors"
);

@@clientLocation(CreationSupportedOperationGroup.list, "CreationSupported");
@@clientLocation(CreationSupportedOperationGroup.get, "CreationSupported");
@@clientName(MonitorsOperationGroup.getAllConnectedResourcesCount::parameters.body,
  "request"
);
@@clientName(MonitorsOperationGroup.getMarketplaceSaaSResourceDetails::parameters.body,
  "request"
);

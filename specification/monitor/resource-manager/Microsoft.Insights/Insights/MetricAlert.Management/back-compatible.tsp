import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MetricAlertResourcePatch.properties);

@@clientLocation(MetricAlertResources.get, "MetricAlerts");
@@clientLocation(MetricAlertResources.createOrUpdate, "MetricAlerts");
@@clientName(MetricAlertResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(MetricAlertResources.update, "MetricAlerts");
@@clientName(MetricAlertResources.update::parameters.properties, "parameters");
@@clientLocation(MetricAlertResources.delete, "MetricAlerts");
@@clientLocation(MetricAlertResources.listByResourceGroup, "MetricAlerts");
@@clientLocation(MetricAlertResources.listBySubscription, "MetricAlerts");
@@clientLocation(MetricAlertResources.list, "MetricAlertsStatus");
@@clientLocation(MetricAlertResources.listByName, "MetricAlertsStatus");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MetricAlertResource.properties);

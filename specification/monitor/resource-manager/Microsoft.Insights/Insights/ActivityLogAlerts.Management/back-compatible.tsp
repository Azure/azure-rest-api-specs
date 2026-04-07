import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AlertRulePatchObject.properties);

@@clientLocation(ActivityLogAlertResources.get, "ActivityLogAlerts");
@@clientLocation(ActivityLogAlertResources.createOrUpdate, "ActivityLogAlerts");
@@clientName(ActivityLogAlertResources.createOrUpdate::parameters.resource,
  "activityLogAlertRule"
);
@@clientLocation(ActivityLogAlertResources.update, "ActivityLogAlerts");
@@clientName(ActivityLogAlertResources.update::parameters.properties,
  "activityLogAlertRulePatch"
);
@@clientLocation(ActivityLogAlertResources.delete, "ActivityLogAlerts");
@@clientLocation(ActivityLogAlertResources.listByResourceGroup,
  "ActivityLogAlerts"
);
@@clientLocation(ActivityLogAlertResources.listBySubscriptionId,
  "ActivityLogAlerts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActivityLogAlertResource.properties);

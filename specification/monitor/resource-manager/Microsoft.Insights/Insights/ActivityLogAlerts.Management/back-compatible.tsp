import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ActivityLogAlerts;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActivityLogAlertResource.properties);

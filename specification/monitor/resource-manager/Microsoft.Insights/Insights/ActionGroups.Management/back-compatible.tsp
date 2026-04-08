import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActionGroupPatchBody.properties);

@@clientLocation(ActionGroupResources.get, "ActionGroups");
@@clientLocation(ActionGroupResources.createOrUpdate, "ActionGroups");
@@clientName(ActionGroupResources.createOrUpdate::parameters.resource,
  "actionGroup"
);
@@clientLocation(ActionGroupResources.update, "ActionGroups");
@@clientName(ActionGroupResources.update::parameters.properties,
  "actionGroupPatch"
);
@@clientLocation(ActionGroupResources.delete, "ActionGroups");
@@clientLocation(ActionGroupResources.listByResourceGroup, "ActionGroups");
@@clientLocation(ActionGroupResources.listBySubscriptionId, "ActionGroups");
@@clientLocation(ActionGroupResources.createNotificationsAtActionGroupResourceLevel,
  "ActionGroups"
);
@@clientName(ActionGroupResources.createNotificationsAtActionGroupResourceLevel::parameters.body,
  "notificationRequest"
);
@@clientLocation(ActionGroupResources.getTestNotificationsAtActionGroupResourceLevel,
  "ActionGroups"
);
@@clientLocation(ActionGroupResources.enableReceiver, "ActionGroups");
@@clientName(ActionGroupResources.enableReceiver::parameters.body,
  "enableRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActionGroupResource.properties);

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(AlertOperationGroup.getResourceGroupLevel, Alerts);
@@clientLocation(AlertOperationGroup.listResourceGroupLevelByRegion, Alerts);
@@clientLocation(AlertOperationGroup.updateResourceGroupLevelStateToResolve,
  Alerts
);
@@clientLocation(AlertOperationGroup.updateResourceGroupLevelStateToDismiss,
  Alerts
);
@@clientLocation(AlertOperationGroup.updateResourceGroupLevelStateToActivate,
  Alerts
);
@@clientLocation(AlertOperationGroup.updateResourceGroupLevelStateToInProgress,
  Alerts
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Alert.properties);

@@clientLocation(AlertsOperationGroup.list, Alerts);
@@clientLocation(AlertsOperationGroup.listByResourceGroup, Alerts);
@@clientLocation(AlertsOperationGroup.simulate, Alerts);

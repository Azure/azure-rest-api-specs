import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Security;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Alert.properties);

@@clientLocation(AlertsOperationGroup.list, Alerts);
@@clientLocation(AlertsOperationGroup.listByResourceGroup, Alerts);
@@clientLocation(AlertsOperationGroup.simulate, Alerts);



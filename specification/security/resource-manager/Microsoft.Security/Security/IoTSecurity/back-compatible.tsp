import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Security;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UpdateIotSecuritySolutionData.properties);

@@clientName(DeviceSecurityGroups.createOrUpdate::parameters.resource,
  "deviceSecurityGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeviceSecurityGroup.properties);

@@clientLocation(IoTSecuritySolutionAnalyticsModels.get,
  "IotSecuritySolutionAnalytics"
);
@@clientLocation(IoTSecuritySolutionAnalyticsModels.list,
  "IotSecuritySolutionAnalytics"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTSecuritySolutionAnalyticsModel.properties);

@@clientLocation(IoTSecurityAggregatedAlerts.get,
  "IotSecuritySolutionsAnalyticsAggregatedAlert"
);
@@clientLocation(IoTSecurityAggregatedAlerts.list,
  "IotSecuritySolutionsAnalyticsAggregatedAlert"
);
@@clientLocation(IoTSecurityAggregatedAlerts.dismiss,
  "IotSecuritySolutionsAnalyticsAggregatedAlert"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTSecurityAggregatedAlert.properties);

@@clientLocation(IoTSecurityAggregatedRecommendations.get,
  "IotSecuritySolutionsAnalyticsRecommendation"
);
@@clientLocation(IoTSecurityAggregatedRecommendations.list,
  "IotSecuritySolutionsAnalyticsRecommendation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTSecurityAggregatedRecommendation.properties);

@@clientLocation(IoTSecuritySolutionModels.get, "IotSecuritySolution");
@@clientLocation(IoTSecuritySolutionModels.createOrUpdate,
  "IotSecuritySolution"
);
@@clientName(IoTSecuritySolutionModels.createOrUpdate::parameters.resource,
  "iotSecuritySolutionData"
);
@@clientLocation(IoTSecuritySolutionModels.update, "IotSecuritySolution");
@@clientName(IoTSecuritySolutionModels.update::parameters.properties,
  "updateIotSecuritySolutionData"
);
@@clientLocation(IoTSecuritySolutionModels.delete, "IotSecuritySolution");
@@clientLocation(IoTSecuritySolutionModels.listByResourceGroup,
  "IotSecuritySolution"
);
@@clientLocation(IoTSecuritySolutionModels.listBySubscription,
  "IotSecuritySolution"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTSecuritySolutionModel.properties);
@@key(Azure.ResourceManager.Extension.ScopeParameter.scope, "resourceId");



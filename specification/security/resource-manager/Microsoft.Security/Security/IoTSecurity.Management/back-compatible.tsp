import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UpdateIotSecuritySolutionData.properties);

@@clientName(DeviceSecurityGroups.createOrUpdate::parameters.resource,
  "deviceSecurityGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeviceSecurityGroup.properties);

@@clientLocation(IoTSecuritySolutionAnalyticsModels.get,
  "IotSecuritySolutionAnalytics"
);
@@clientLocation(IoTSecuritySolutionAnalyticsModels.list,
  "IotSecuritySolutionAnalytics"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IoTSecurityAggregatedAlert.properties);

@@clientLocation(IoTSecurityAggregatedRecommendations.get,
  "IotSecuritySolutionsAnalyticsRecommendation"
);
@@clientLocation(IoTSecurityAggregatedRecommendations.list,
  "IotSecuritySolutionsAnalyticsRecommendation"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IoTSecuritySolutionModel.properties);

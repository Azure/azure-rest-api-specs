import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutoscaleSettingResourcePatch.properties);

@@clientLocation(AutoscaleSettingResources.get, "AutoscaleSettings");
@@clientLocation(AutoscaleSettingResources.createOrUpdate, "AutoscaleSettings");
@@clientName(AutoscaleSettingResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AutoscaleSettingResources.update, "AutoscaleSettings");
@@clientName(AutoscaleSettingResources.update::parameters.properties,
  "autoscaleSettingResource"
);
@@clientLocation(AutoscaleSettingResources.delete, "AutoscaleSettings");
@@clientLocation(AutoscaleSettingResources.listByResourceGroup,
  "AutoscaleSettings"
);
@@clientLocation(AutoscaleSettingResources.listBySubscription,
  "AutoscaleSettings"
);
@@clientLocation(AutoscaleSettingResources.predictiveMetricGet,
  "PredictiveMetric"
);
@@clientName(AutoscaleSettingResources.predictiveMetricGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutoscaleSettingResource.properties);

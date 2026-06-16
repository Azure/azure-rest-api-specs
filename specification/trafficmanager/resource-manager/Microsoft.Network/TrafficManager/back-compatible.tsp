import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(DeleteOperationResult.boolean, "operationResult");

@@clientName(Endpoints.createOrUpdate::parameters.resource, "parameters");
@@clientName(Endpoints.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Endpoint.properties);

@@clientName(Profiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(Profiles.update::parameters.properties, "parameters");

@@clientName(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability::parameters.body,
  "parameters"
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2::parameters.body,
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Profile.properties);

@@clientLocation(TrafficManagerGeographicHierarchies.getDefault,
  "GeographicHierarchies"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TrafficManagerGeographicHierarchy.properties
);

@@clientLocation(HeatMapModels.get, "HeatMap");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HeatMapModel.properties);

@@clientLocation(UserMetricsModels.get, "TrafficManagerUserMetricsKeys");

@@clientLocation(UserMetricsModels.createOrUpdate,
  "TrafficManagerUserMetricsKeys"
);

@@clientLocation(UserMetricsModels.delete, "TrafficManagerUserMetricsKeys");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UserMetricsModel.properties
);

@@clientLocation(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  Profiles
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  "CheckTrafficManagerRelativeDnsNameAvailability"
);
@@clientLocation(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  Profiles
);
@@clientLocation(HeatMapModels.get, "HeatMap");

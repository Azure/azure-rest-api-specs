import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(DeleteOperationResult.boolean, "operationResult");

@@clientName(Endpoints.createOrUpdate::parameters.resource, "parameters");
@@clientName(Endpoints.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Endpoint.properties);

@@clientName(Profiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(Profiles.update::parameters.properties, "parameters");

@@clientName(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability::parameters.body,
  "parameters"
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2::parameters.body,
  "parameters"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Profile.properties);

@@clientLocation(TrafficManagerGeographicHierarchies.getDefault,
  "GeographicHierarchies"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TrafficManagerGeographicHierarchy.properties);

@@clientLocation(HeatMapModels.get, "HeatMap");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HeatMapModel.properties);

@@clientLocation(UserMetricsModels.get, "TrafficManagerUserMetricsKeys");
@@clientName(UserMetricsModels.get, "Get");

@@clientLocation(UserMetricsModels.createOrUpdate,
  "TrafficManagerUserMetricsKeys"
);
@@clientName(UserMetricsModels.createOrUpdate, "CreateOrUpdate");

@@clientLocation(UserMetricsModels.delete, "TrafficManagerUserMetricsKeys");
@@clientName(UserMetricsModels.delete, "Delete");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UserMetricsModel.properties);

@@clientLocation(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  Profiles
);
@@clientLocation(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  Profiles
);

@@clientLocation(HeatMapModels.get, "HeatMap");
@@clientName(HeatMapModels.get, "Get");

@@clientLocation(Profiles.get, "Profiles");
@@clientLocation(Profiles.listByResourceGroup, "Profiles");

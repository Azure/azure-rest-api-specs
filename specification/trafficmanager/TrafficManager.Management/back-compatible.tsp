import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Network;

@@clientName(DeleteOperationResult.boolean, "operationResult");

@@clientName(Endpoints.createOrUpdate::parameters.resource, "parameters");
@@clientName(Endpoints.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Endpoint.properties);

@@clientName(Profiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(Profiles.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Profile.properties);

@@clientLocation(TrafficManagerGeographicHierarchies.getDefault,
  "GeographicHierarchies"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TrafficManagerGeographicHierarchy.properties);

@@clientLocation(HeatMapModels.get, "HeatMap");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HeatMapModel.properties);

@@clientLocation(UserMetricsModels.get, "TrafficManagerUserMetricsKeys");
@@clientLocation(UserMetricsModels.createOrUpdate,
  "TrafficManagerUserMetricsKeys"
);
@@clientLocation(UserMetricsModels.delete, "TrafficManagerUserMetricsKeys");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserMetricsModel.properties);

@@clientLocation(ProfilesOperationGroup.checkTrafficManagerRelativeDnsNameAvailability,
  Profiles
);
@@clientLocation(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  Profiles
);
@@clientName(ProfilesOperationGroup.checkTrafficManagerNameAvailabilityV2,
  "checkTrafficManagerNameAvailabilityV2"
);

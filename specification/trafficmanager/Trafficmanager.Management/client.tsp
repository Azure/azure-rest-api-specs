import "./main.tsp";
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TrafficManagerGeographicHierarchy.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HeatMapModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserMetricsModel.properties);

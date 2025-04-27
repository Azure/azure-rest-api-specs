import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Dashboard;

@@clientName(ManagedGrafanas.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedGrafanas.update::parameters.properties,
  "requestBodyParameters"
);

@@clientName(PrivateEndpointConnections.approve::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(ManagedPrivateEndpointModels.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(ManagedPrivateEndpointModels.update::parameters.properties,
  "requestBodyParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedPrivateEndpointModel.properties);

@@clientName(IntegrationFabrics.create::parameters.resource,
  "requestBodyParameters"
);
@@clientName(IntegrationFabrics.update::parameters.properties,
  "requestBodyParameters"
);

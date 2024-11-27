import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.HybridConnectivity;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceConfigurationResourcePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EndpointAccessResource.relay);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressGatewayResource.relay);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressGatewayResource.ingress);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IngressProfileProperties.aadProfile);

@@clientName(EndpointResources.update,
  "EndpointResources.update::parameters.properties",
  "EndpointResource"
);
@@clientName(EndpointResources.listCredentials,
  "EndpointResources.listCredentials::parameters.body",
  "ListCredentialsRequest"
);
@@clientName(EndpointResources.listManagedProxyDetails,
  "EndpointResources.listManagedProxyDetails::parameters.body",
  "ManagedProxyRequest"
);

@@clientName(ServiceConfigurationResources.update,
  "ServiceConfigurationResources.update::parameters.properties",
  "ServiceConfigurationResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceConfigurationResource.properties);

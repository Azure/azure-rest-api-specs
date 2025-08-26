import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
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

@@clientName(EndpointResources.createOrUpdate::parameters.resource,
  "EndpointResource"
);
@@clientName(EndpointResources.listManagedProxyDetails::parameters.body,
  "ManagedProxyRequest"
);
@@clientName(ServiceConfigurationResources.update::parameters.properties,
  "ServiceConfigurationResource"
);
@@clientName(EndpointResources.update::parameters.properties,
  "EndpointResource"
);
@@clientName(ServiceConfigurationResources.createOrupdate::parameters.resource,
  "ServiceConfigurationResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceConfigurationResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PublicCloudConnectorUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SolutionConfigurationUpdate.properties);

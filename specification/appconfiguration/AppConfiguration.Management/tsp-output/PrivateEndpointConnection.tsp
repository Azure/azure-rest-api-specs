import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
@doc("A private endpoint connection")
@parentResource(ConfigurationStore)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("Private endpoint connection name")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets the specified private endpoint connection associated with the configuration store.")
  get is ArmResourceRead<PrivateEndpointConnection>;

  @doc("Update the state of the specified private endpoint connection associated with the configuration store.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateEndpointConnection>;

  @doc("Deletes a private endpoint connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  @doc("Lists all private endpoint connections for a configuration store.")
  listByConfigurationStore is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "json",
  "privateEndpointConnection"
);
@@extension(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateEndpointConnection"
);
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "The private endpoint connection properties."
);

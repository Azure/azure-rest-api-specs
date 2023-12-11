import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Relay;
@doc("Properties of the PrivateEndpointConnection.")
@parentResource(RelayNamespace)
model RelayPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The PrivateEndpointConnection name")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface RelayPrivateEndpointConnections {
  @doc("Gets a description for the specified Private Endpoint Connection name.")
  get is ArmResourceRead<RelayPrivateEndpointConnection>;
  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<RelayPrivateEndpointConnection>;
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  delete is ArmResourceDeleteAsync<RelayPrivateEndpointConnection>;
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  list is ArmResourceListByParent<RelayPrivateEndpointConnection>;
}

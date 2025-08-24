import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Properties of the PrivateEndpointConnection.")
@parentResource(ServiceBusNamespace)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The PrivateEndpointConnection name")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Gets a description for the specified Private Endpoint Connection.")
  get is ArmResourceRead<PrivateEndpointConnection>;
  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;
  @doc("Deletes an existing Private Endpoint Connection.")
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ServiceBus;
@doc("Properties of the PrivateEndpointConnection.")
@parentResource(ServiceBusNamespace)
model ServiceBusPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The PrivateEndpointConnection name")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface ServiceBusPrivateEndpointConnections {
  @doc("Gets a description for the specified Private Endpoint Connection.")
  get is ArmResourceRead<ServiceBusPrivateEndpointConnection>;
  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusPrivateEndpointConnection>;
  @doc("Deletes an existing Private Endpoint Connection.")
  delete is ArmResourceDeleteAsync<ServiceBusPrivateEndpointConnection>;
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  list is ArmResourceListByParent<ServiceBusPrivateEndpointConnection>;
}

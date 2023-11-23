import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Properties of the PrivateEndpointConnection.")
@parentResource(EHNamespace)
model EventHubManagementClientPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The PrivateEndpointConnection name")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface EventHubManagementClientPrivateEndpointConnections {
  @doc("Gets a description for the specified Private Endpoint Connection name.")
  get is ArmResourceRead<EventHubManagementClientPrivateEndpointConnection>;
  @doc("Creates or updates PrivateEndpointConnections of service namespace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<EventHubManagementClientPrivateEndpointConnection>;
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  delete is ArmResourceDeleteAsync<EventHubManagementClientPrivateEndpointConnection>;
  @doc("Gets the available PrivateEndpointConnections within a namespace.")
  list is ArmResourceListByParent<EventHubManagementClientPrivateEndpointConnection>;
}

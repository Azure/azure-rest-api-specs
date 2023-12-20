import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("The Private Endpoint Connection resource.")
@parentResource(MonitorPrivateLinkScope)
model MonitorPrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  @doc("The name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface MonitorPrivateEndpointConnections {
  @doc("Gets a private endpoint connection.")
  get is ArmResourceRead<MonitorPrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection with a given name.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MonitorPrivateEndpointConnection>;
  @doc("Deletes a private endpoint connection with a given name.")
  delete is ArmResourceDeleteAsync<MonitorPrivateEndpointConnection>;
  @doc("Gets all private endpoint connections on a private link scope.")
  listByPrivateLinkScope is ArmResourceListByParent<MonitorPrivateEndpointConnection>;
}

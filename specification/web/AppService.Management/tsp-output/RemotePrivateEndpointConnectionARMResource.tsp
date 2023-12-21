import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Remote Private Endpoint Connection ARM resource.")
@parentResource(AppServiceEnvironmentResource)
model RemotePrivateEndpointConnectionARMResource
  is ProxyResource<RemotePrivateEndpointConnectionARMResourceProperties> {
  @doc("Name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface AppServiceEnvironments {
  @doc("Description for Gets a private endpoint connection")
  getPrivateEndpointConnection is ArmResourceRead<RemotePrivateEndpointConnectionARMResource>;
  @doc("Description for Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnection is ArmResourceCreateOrUpdateAsync<RemotePrivateEndpointConnectionARMResource>;
  @doc("Description for Deletes a private endpoint connection")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<RemotePrivateEndpointConnectionARMResource>;
  @doc("Description for Gets the list of private endpoints associated with a hosting environment")
  getPrivateEndpointConnectionList is ArmResourceListByParent<RemotePrivateEndpointConnectionARMResource>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Remote Private Endpoint Connection ARM resource.")
@parentResource(AppServiceEnvironment)
model HostingEnvironmentPrivateEndpointConnection
  is ProxyResource<RemotePrivateEndpointConnectionARMResourceProperties> {
  @doc("Name of the private endpoint connection.")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface HostingEnvironmentPrivateEndpointConnections {
  @doc("Description for Gets a private endpoint connection")
  getPrivateEndpointConnection is ArmResourceRead<HostingEnvironmentPrivateEndpointConnection>;
  @doc("Description for Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnection is ArmResourceCreateOrUpdateAsync<HostingEnvironmentPrivateEndpointConnection>;
  @doc("Description for Deletes a private endpoint connection")
  deletePrivateEndpointConnection is ArmResourceDeleteAsync<HostingEnvironmentPrivateEndpointConnection>;
  @doc("Description for Gets the list of private endpoints associated with a hosting environment")
  getPrivateEndpointConnectionList is ArmResourceListByParent<HostingEnvironmentPrivateEndpointConnection>;
}

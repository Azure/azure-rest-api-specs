import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
// FIXME: PrivateEndpointConnectionWithSystemData has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(Workspace)
model PrivateEndpointConnectionWithSystemData is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  @doc("Get a private endpoint connection.")
  getByWorkspace is ArmResourceRead<PrivateEndpointConnectionWithSystemData>;
  @doc("Approve or reject a private endpoint connection.")
  updateByWorkspace is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionWithSystemData>;
  @doc("Remove a connection.")
  deleteByWorkspace is ArmResourceDeleteSync<PrivateEndpointConnectionWithSystemData>;
  @doc("List private endpoint connections.")
  listByWorkspace is ArmResourceListByParent<PrivateEndpointConnectionWithSystemData>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
// FIXME: WorkspacePrivateEndpointConnection has no properties property
@doc("The Private Endpoint Connection resource.")
@parentResource(Workspace)
model WorkspacePrivateEndpointConnection is ProxyResource<{}> {
  @doc("The name of the private endpoint connection associated with the Azure resource")
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;
}

@armResourceOperations
interface WorkspacePrivateEndpointConnections {
  @doc("Get a private endpoint connection.")
  getByWorkspace is ArmResourceRead<WorkspacePrivateEndpointConnection>;
  @doc("Approve or reject a private endpoint connection.")
  updateByWorkspace is ArmResourceCreateOrReplaceSync<WorkspacePrivateEndpointConnection>;
  @doc("Remove a connection.")
  deleteByWorkspace is ArmResourceDeleteSync<WorkspacePrivateEndpointConnection>;
  @doc("List private endpoint connections.")
  listByWorkspace is ArmResourceListByParent<WorkspacePrivateEndpointConnection>;
}

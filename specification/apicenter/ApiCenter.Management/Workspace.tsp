import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;
@doc("Workspace entity.")
@parentResource(Service)
model Workspace is ProxyResource<WorkspaceProperties> {
  @doc("The name of the workspace.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface Workspaces {
  @doc("Returns details of the workspace.")
  get is ArmResourceRead<Workspace>;
  @doc("Checks if specified workspace exists.")
  @head
  head(
    ...ResourceInstanceParameters<Workspace, BaseParameters<Workspace>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing workspace.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workspace>;
  @doc("Deletes specified workspace.")
  delete is ArmResourceDeleteSync<Workspace>;
  @doc("Returns a collection of workspaces.")
  list is ArmResourceListByParent<Workspace>;
}

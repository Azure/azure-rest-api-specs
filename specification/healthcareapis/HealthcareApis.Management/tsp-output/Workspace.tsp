import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HealthcareApis;
@doc("Workspace resource.")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of workspace resource.")
  @maxLength(24)
  @minLength(3)
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface Workspaces {
  @doc("Gets the properties of the specified workspace.")
  get is ArmResourceRead<Workspace>;

  @doc("Creates or updates a workspace resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Workspace>;

  @doc("Patch workspace details.")
  update is ArmCustomPatchAsync<Workspace, WorkspacePatchResource>;

  @doc("Deletes a specified workspace.")
  delete is ArmResourceDeleteAsync<Workspace>;

  @doc("Lists all the available workspaces under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  @doc("Lists all the available workspaces under the specified subscription.")
  listBySubscription is ArmListBySubscription<Workspace>;
}

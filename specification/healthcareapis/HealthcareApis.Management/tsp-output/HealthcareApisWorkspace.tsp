import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HealthcareApis;
@doc("Workspace resource.")
model HealthcareApisWorkspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of workspace resource.")
  @maxLength(24)
  @minLength(3)
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface HealthcareApisWorkspaces {
  @doc("Gets the properties of the specified workspace.")
  get is ArmResourceRead<HealthcareApisWorkspace>;
  @doc("Creates or updates a workspace resource with the specified parameters.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<HealthcareApisWorkspace>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Patch workspace details.")
  update is ArmCustomPatchAsync<
    HealthcareApisWorkspace,
    WorkspacePatchResource
  >;
  @doc("Deletes a specified workspace.")
  delete is ArmResourceDeleteAsync<HealthcareApisWorkspace>;
  @doc("Lists all the available workspaces under the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<HealthcareApisWorkspace>;
  @doc("Lists all the available workspaces under the specified subscription.")
  listBySubscription is ArmListBySubscription<HealthcareApisWorkspace>;
}

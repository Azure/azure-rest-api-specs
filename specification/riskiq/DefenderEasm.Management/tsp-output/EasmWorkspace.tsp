import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DefenderEasm;
@doc("Workspace details.")
model EasmWorkspace is TrackedResource<WorkspaceResourceProperties> {
  @doc("The name of the Workspace.")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface EasmWorkspaces {
  @doc("Returns a workspace with the given name.")
  get is ArmResourceRead<EasmWorkspace>;
  @doc("Create or update a Workspace.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<EasmWorkspace>;
  @doc("Update a Workspace.")
  update is ArmTagsPatchSync<EasmWorkspace>;
  @doc("Delete a Workspace.")
  delete is ArmResourceDeleteWithoutOkAsync<EasmWorkspace>;
  @doc("Returns a list of workspaces in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<EasmWorkspace>;
  @doc("Returns a list of workspaces under the given subscription.")
  listBySubscription is ArmListBySubscription<EasmWorkspace>;
  @doc("Returns a task in the given workspace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Easm/workspaces/{workspaceName}/tasks/{taskId}")
  @get
  GetByWorkspace is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the Workspace.")
      @path
      workspaceName: string;

      @doc("The id of the Task.")
      @path
      taskId: string;
    },
    TaskResource
  >;
}

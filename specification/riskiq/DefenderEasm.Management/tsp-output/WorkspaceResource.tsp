import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Easm;
@doc("Workspace details.")
model WorkspaceResource is TrackedResource<WorkspaceResourceProperties> {
  @doc("The name of the Workspace.")
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
@projectedName("client", "Workspaces")
interface WorkspaceResources_Workspaces {
  @doc("Returns a workspace with the given name.")
  get is ArmResourceRead<WorkspaceResource>;

  @doc("Create or update a Workspace.")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<WorkspaceResource>;

  @doc("Update a Workspace.")
  update is ArmCustomPatchSync<WorkspaceResource, WorkspacePatchResource>;

  @doc("Delete a Workspace.")
  delete is ArmResourceDeleteWithoutOkAsync<WorkspaceResource>;

  @doc("Returns a list of workspaces in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<WorkspaceResource>;

  @doc("Returns a list of workspaces under the given subscription.")
  listBySubscription is ArmListBySubscription<WorkspaceResource>;
}

@armResourceOperations
@projectedName("client", "Tasks")
interface WorkspaceResources_Tasks {
  @doc("Returns a task in the given workspace.")
  // FIXME: Tasks_GetByWorkspace could not be converted to a resource operation
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

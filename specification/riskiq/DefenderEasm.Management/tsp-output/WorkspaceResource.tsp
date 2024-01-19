import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Easm;
@doc("Workspace details.")
model WorkspaceResource is TrackedResource<WorkspaceResourceProperties> {
  @doc("The name of the Workspace.")
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface WorkspaceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a workspace with the given name.")
  @operationId("Workspaces_Get")
  get is ArmResourceRead<WorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a Workspace.")
  @operationId("Workspaces_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrUpdateAsync<
    WorkspaceResource,
    BaseParameters<WorkspaceResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a Workspace.")
  @operationId("Workspaces_Update")
  update is ArmCustomPatchSync<WorkspaceResource, WorkspacePatchResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Workspace.")
  @operationId("Workspaces_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkspaceResource,
    BaseParameters<WorkspaceResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of workspaces in the given resource group.")
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns a list of workspaces under the given subscription.")
  @operationId("Workspaces_ListBySubscription")
  listBySubscription is ArmListBySubscription<WorkspaceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_GetByWorkspace")
  @doc("Returns a task in the given workspace.")
  // FIXME: Tasks_GetByWorkspace could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Easm/workspaces/{workspaceName}/tasks/{taskId}")
  @get
  getByWorkspace is Azure.Core.Foundations.Operation<
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

@@projectedName(WorkspaceResources.createAndUpdate::parameters.resource,
  "json",
  "WorkspaceResource"
);
@@extension(WorkspaceResources.createAndUpdate::parameters.resource,
  "x-ms-client-name",
  "WorkspaceResource"
);
@@doc(WorkspaceResources.createAndUpdate::parameters.resource,
  "Workspace details."
);
@@projectedName(WorkspaceResources.update::parameters.properties,
  "json",
  "WorkspacePatchResource"
);
@@extension(WorkspaceResources.update::parameters.properties,
  "x-ms-client-name",
  "WorkspacePatchResource"
);
@@doc(WorkspaceResources.update::parameters.properties,
  "Workspace patch details."
);

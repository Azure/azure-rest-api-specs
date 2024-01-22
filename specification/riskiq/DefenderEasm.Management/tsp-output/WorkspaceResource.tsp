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
/**
 * Workspace details.
 */
model WorkspaceResource is TrackedResource<WorkspaceResourceProperties> {
  /**
   * The name of the Workspace.
   */
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;
}

@armResourceOperations
interface WorkspaceResources {
  /**
   * Returns a workspace with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_Get")
  get is ArmResourceRead<WorkspaceResource>;

  /**
   * Create or update a Workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_CreateAndUpdate")
  createAndUpdate is ArmResourceCreateOrReplaceAsync<
    WorkspaceResource,
    BaseParameters<WorkspaceResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a Workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Workspaces_Update")
  update is ArmCustomPatchSync<WorkspaceResource, WorkspacePatchResource>;

  /**
   * Delete a Workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    WorkspaceResource,
    BaseParameters<WorkspaceResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Returns a list of workspaces in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WorkspaceResource>;

  /**
   * Returns a list of workspaces under the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListBySubscription")
  listBySubscription is ArmListBySubscription<WorkspaceResource>;

  /**
   * Returns a task in the given workspace.
   */
  // FIXME: Tasks_GetByWorkspace could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_GetByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Easm/workspaces/{workspaceName}/tasks/{taskId}")
  @get
  getByWorkspace is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the Workspace.
       */
      @path
      workspaceName: string;

      /**
       * The id of the Task.
       */
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

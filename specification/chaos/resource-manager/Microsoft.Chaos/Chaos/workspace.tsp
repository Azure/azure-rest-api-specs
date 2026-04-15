import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./workspace.models.tsp";
import "./workspaceEvaluation.models.tsp";
import "./lro-helpers.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface Workspaces {
  /**
   * Get a Workspace resource.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Create or update a Workspace resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;

  /**
   * The operation to update a Workspace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Workspace, WorkspaceUpdate>;

  /**
   * Delete a Workspace resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "ARM reviewer requires 200 response on delete per RPC-Delete-V1-03"
  delete is ArmResourceDeleteAsyncBase<
    Workspace,
    ArmDeletedResponse | ArmDeleteAcceptedLroResponse | WorkspaceDeleteNoContentResponse
  >;

  /**
   * Get a list of Workspace resources in a resource group.
   */
  list is ArmResourceListByParent<
    Workspace,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = WorkspaceListResult
  >;

  /**
   * Get a list of all Workspace resources in a subscription.
   */
  listAll is ArmListBySubscription<
    Workspace,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = WorkspaceListResult
  >;

  /**
   * Refreshes recommendation status for all scenarios in a given workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Async LRO POST returning 202 + Location, not a synchronous POST"
  @pollingOperation(WorkspaceEvaluations.getLatest)
  refreshRecommendations is ArmResourceActionNoContentAsyncWithLocationResult<
    Workspace,
    void,
    WorkspaceEvaluation
  >;
}

@@minLength(Workspace.name, 1);
@@doc(Workspace.name, "String that represents a Workspace resource name.");
@@doc(Workspace.properties, "The properties of the Workspace resource.");
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "Workspace resource to be created or updated."
);
@@doc(Workspaces.update::parameters.properties,
  "Parameters supplied to the Update Workspace operation."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./workspace.models.tsp";
import "./workspaceEvaluation.models.tsp";
import "./workspaceDiscovery.models.tsp";
import "./lro-helpers.tsp";
import "./put-preconditions.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@armResourceOperations
interface Workspaces {
  /**
   * Get a Workspace resource.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Create or update a Workspace resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Parameters = PutPreconditionHeaders
  >;

  /**
   * Update a Workspace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Workspace, WorkspaceUpdate>;

  /**
   * Delete a Workspace resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;

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
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  refreshRecommendations is ArmResourceActionNoContentAsyncWithLocationResult<
    Workspace,
    void,
    LegacyWorkspaceEvaluation
  >;

  /**
   * Triggers resource discovery for the workspace.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "discover")
  @sharedRoute
  @action("discover")
  discoverLegacy is ArmResourceActionNoContentAsyncWithLocationResult<
    Workspace,
    void,
    LegacyWorkspaceDiscovery
  >;

  /**
   * Triggers scenario evaluation for the workspace.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "evaluate")
  @sharedRoute
  @action("evaluate")
  evaluateLegacy is ArmResourceActionNoContentAsyncWithLocationResult<
    Workspace,
    void,
    LegacyWorkspaceEvaluation
  >;

  /**
   * Starts discovery for the workspace. The initial 202 has no body. Poll the operation-bound Location URL until completion: a successful or partially successful discovery returns the typed result; failed or canceled processing returns an Azure error whose target identifies the discovery resource. Ordinary discovery reads return the current resource, including failed or canceled results, while retained.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @sharedRoute
  @action("discover")
  @Azure.Core.useFinalStateVia("location")
  discover is ArmResourceActionAsync<Workspace, void, WorkspaceDiscovery>;

  /**
   * Starts evaluation of published scenario-template versions, including when the workspace has no scenarios. Acceptance fixes the selected template membership and total count, qualified resource snapshot and canonical discovery result reference. Without a usable discovery snapshot or valid catalog input, the request is rejected synchronously with an Azure error and no evaluation result is created. A valid empty catalog completes successfully with zero counts and an empty results array. Outcome counts reflect processing after acceptance. The initial 202 has no body. Poll the operation-bound Location URL until completion: a completed successful or partially successful assessment returns the typed result; failed or canceled processing returns an Azure error whose target identifies the evaluation resource. Ordinary evaluation reads return the current resource, including failed or canceled results, while retained.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @sharedRoute
  @action("evaluate")
  @Azure.Core.useFinalStateVia("location")
  evaluate is ArmResourceActionAsync<Workspace, void, WorkspaceEvaluation>;
}

@@minLength(Workspace.name, 1);
@@doc(Workspace.name, "String that represents a Workspace resource name.");
@@doc(Workspace.properties, "The properties of the Workspace resource.");
@@doc(
  Workspaces.createOrUpdate::parameters.resource,
  "Workspace resource to be created or updated."
);
@@doc(
  Workspaces.update::parameters.properties,
  "Parameters supplied to the Update Workspace operation."
);

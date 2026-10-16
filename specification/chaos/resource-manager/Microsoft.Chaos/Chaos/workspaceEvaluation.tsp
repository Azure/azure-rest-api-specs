import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";
import "./workspaceEvaluation.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Ordinary reads of retained workspace scenario-template evaluations, separate from LRO polling.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface WorkspaceEvaluations {
  /**
   * Gets a retained template evaluation by its ID, or uses latest to select the most recently durably admitted GA template evaluation. Returns 200 with the current representation while processing or terminal. Returns 404 if no qualifying retained result exists; scenario-backed legacy operations are not substituted. This is not an LRO polling endpoint.
   */
  get is ArmResourceRead<
    WorkspaceEvaluation,
    Error =
      | Azure.ResourceManager.CommonTypes.ErrorResponse
      | (ArmResourceNotFoundResponse &
          Body<Azure.ResourceManager.CommonTypes.ErrorResponse>)
  >;

  /**
   * Lists retained GA template evaluations under the workspace. Each result has its canonical ID; latest is an alias and is not a separate collection entry. This operation does not extend retention or convert scenario-backed legacy evaluations.
   */
  list is ArmResourceListByParent<
    WorkspaceEvaluation,
    Parameters = {
      /** Opaque continuation token supplied by the returned nextLink. */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

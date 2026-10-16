import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";
import "./workspaceDiscovery.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Ordinary reads of retained workspace discovery results, separate from LRO polling.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface WorkspaceDiscoveries {
  /**
   * Gets a retained discovery result by its ID, or uses latest to select the most recently durably admitted discovery. Returns 200 with the current representation while processing or terminal. A Failed result can contain errors without a snapshot. Returns 404 if no qualifying retained result exists. This is not an LRO polling endpoint.
   */
  get is ArmResourceRead<WorkspaceDiscovery>;

  /**
   * Lists retained discovery results under the workspace. Each result has its canonical ID; latest is an alias and is not a separate collection entry. This operation does not extend result retention.
   */
  list is ArmResourceListByParent<
    WorkspaceDiscovery,
    Parameters = {
      /** Opaque continuation token supplied by the returned nextLink. */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}

@@doc(
  WorkspaceDiscovery.name,
  "The service-generated discovery result ID. Use latest in the request path for the most recently durably admitted discovery; responses contain the canonical result ID."
);

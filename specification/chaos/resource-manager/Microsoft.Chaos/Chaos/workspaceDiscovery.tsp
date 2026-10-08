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
 * The latest discovery result used to monitor workspace discovery and inspect its accepted coverage.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface WorkspaceDiscoveries {
  /**
   * Gets the latest discovery result. Returns 202 with Location pointing to this same polling resource while discovery is processing, and 200 for a terminal result, including Failed with an error and no snapshot when completion could not be accepted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing discovery polling GET returns its read-only nonterminal result with HTTP 202; the initiating POST still returns 202 without a body. Requires ARM API review."
  get is ArmResourceRead<
    WorkspaceDiscovery,
    Response = ArmResponse<WorkspaceDiscovery> | WorkspaceDiscoveryPendingResult
  >;
}

/**
 * The nonterminal discovery result returned from the polling location.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model WorkspaceDiscoveryPendingResult {
  ...ArmAcceptedResponse<"Workspace discovery is still processing.">;

  /** The absolute URL of this same discovery polling resource, including the requested API version. */
  @header("Location")
  location: url;

  /** The nonterminal discovery result, without invented completed coverage facts. */
  @bodyRoot
  body: WorkspaceDiscovery;
}

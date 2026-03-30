import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./common.models.tsp";
import "./workspace.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Chaos;

/**
 * Chaos Studio workspace async operation result resource operations.
 * This is a shared LRO polling endpoint for workspace PUT/PATCH async operations.
 * The response body is a Workspace resource when polling completes.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This is an LRO polling endpoint, not a resource collection"
@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
interface WorkspaceOperationResults {
  /**
   * Returns the result of a workspace async operation.
   * For workspace create/update operations, the response body is a Workspace resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "LRO polling endpoint"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern, not status monitor"
  @summary("Returns the result of a workspace async operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Chaos/locations/{location}/workspaceOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationParameter,

    /**
     * The operation id.
     */
    @path
    operationId: string,
  ): ArmResponse<Workspace> | (AcceptedResponse & {
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    @header("Location")
    location: string;

    @doc("The Retry-After header can indicate how long the client should wait before polling the operation status.")
    @header("Retry-After")
    retryAfter?: int32;
  }) | ErrorResponse;
}

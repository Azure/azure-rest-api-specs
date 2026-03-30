import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "./workspaceEvaluation.models.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface WorkspaceEvaluations {
  /**
   * Get the latest evaluation for the workspace, including per-scenario results and status.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "LRO polling endpoint that returns body in both 200 and 202"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO polling endpoint returns body in 202 to reflect current status"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern, not status monitor"
  @summary("Get the latest evaluation for the workspace.")
  @autoRoute
  @armResourceRead(WorkspaceEvaluation)
  @get
  getLatest(
    ...ResourceInstanceParameters<WorkspaceEvaluation>,
  ): ArmResponse<WorkspaceEvaluation> | (AcceptedResponse & {
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    @header("Location")
    location: string;

    @doc("The Retry-After header can indicate how long the client should wait before polling the operation status.")
    @header("Retry-After")
    retryAfter?: int32;

    @bodyRoot body: WorkspaceEvaluation;
  }) | ErrorResponse;
}

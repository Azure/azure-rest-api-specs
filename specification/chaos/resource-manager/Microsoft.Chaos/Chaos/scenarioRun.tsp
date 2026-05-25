import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "./scenarioRun.models.tsp";
import "./lro-helpers.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@armResourceOperations
interface ScenarioRuns {
  /**
   * Get a scenario run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "LRO polling endpoint that returns body in both 200 and 202"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO polling endpoint returns body in 202 to reflect current status"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern, not status monitor"
  @summary("Get a scenario run.")
  @autoRoute
  @armResourceRead(ScenarioRun)
  @get
  get(...ResourceInstanceParameters<ScenarioRun>):
    | ArmResponse<ScenarioRun>
    | (AcceptedResponse & {
        @doc("The Location header contains the URL where the status of the long running operation can be checked.")
        @header("Location")
        location: string;

        @doc("The Retry-After header can indicate how long the client should wait before polling the operation status.")
        @header("Retry-After")
        retryAfter?: int32;

        @bodyRoot body: ScenarioRun;
      })
    | ErrorResponse;

  /**
   * Get a list of scenario runs.
   */
  listAll is ArmResourceListByParent<
    ScenarioRun,
    Response = ScenarioRunListResult
  >;

  /**
   * Cancel the currently running scenario execution.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 202 with Location header for polling; final result obtained by polling the Location URL"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern"
  @added(Microsoft.Chaos.Versions.v2026_05_01_preview)
  @pollingOperation(ScenarioRuns.get)
  cancel is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioRun,
    void,
    ScenarioRun
  >;
}

@@doc(ScenarioRun.properties, "The properties of scenario run.");

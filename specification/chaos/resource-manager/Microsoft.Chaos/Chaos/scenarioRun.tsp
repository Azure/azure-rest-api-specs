import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./scenarioRun.models.tsp";
import "./lro-helpers.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface ScenarioRuns {
  /**
   * Get a scenario run.
   *
   * This endpoint is also the polling target for ScenarioConfigurations.execute
   * and ScenarioRuns.cancel (final-state-via: location). While the run is in
   * progress the service returns 202 with a Location header pointing back to
   * this URL; clients must keep polling until they receive 200, which carries
   * the final ScenarioRun body.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "LRO polling endpoint that returns body in both 200 and 202 responses."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO polling endpoint returns body in 202 to reflect the current run state."
  get is ArmResourceRead<
    ScenarioRun,
    Response = ArmResponse<ScenarioRun> | ScenarioRunInProgressResponse
  >;

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
  @added(Microsoft.Chaos.Versions.v2026_05_01_preview)
  cancel is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioRun,
    void,
    ScenarioRun
  >;
}

@@doc(ScenarioRun.properties, "The properties of scenario run.");

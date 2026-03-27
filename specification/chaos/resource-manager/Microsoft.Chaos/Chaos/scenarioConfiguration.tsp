import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "./scenarioConfiguration.models.tsp";
import "./scenarioRun.models.tsp";
import "./scenarioRun.tsp";
import "./common.models.tsp";
import "./lro-helpers.tsp";

using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@removed(Microsoft.Chaos.Versions.v2025_01_01)
@armResourceOperations
interface ScenarioConfigurations {
  /**
   * Get a scenario definition.
   */
  get is ArmResourceRead<ScenarioConfiguration>;

  /**
   * Create or update a scenario definition.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScenarioConfiguration>;

  /**
   * Delete a scenario definition.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ScenarioConfiguration>;

  /**
   * Get a list of scenario definitions.
   */
  listAll is ArmResourceListByParent<
    ScenarioConfiguration,
    Response = ScenarioConfigurationListResult
  >;

  /**
   * Execute the scenario execution with the given scenario configuration.
   */
  @pollingOperation(ScenarioRuns.get)
  execute is ArmResourceActionAsyncWithLocation<
    ScenarioConfiguration,
    void,
    ScenarioRun
  >;

  /**
   * Cancel the currently running scenario execution.
   */
  @removed(Microsoft.Chaos.Versions.v2026_05_01_preview)
  @pollingOperation(ScenarioRuns.get)
  cancel is ArmResourceActionAsyncWithLocation<
    ScenarioConfiguration,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult
  >;

  /**
   * Validate the given scenario configuration.
   */
  @pollingOperation(ScenarioConfigurations.getLatestValidation)
  validate is ArmResourceActionAsyncWithLocation<
    ScenarioConfiguration,
    void,
    Validation
  >;

  /**
   * Fixes resource permissions for the given scenario configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 200+202, custom template not recognized by linter"
  @pollingOperation(ScenarioConfigurations.getLatestPermissionsFix)
  fixResourcePermissions is ArmResourceActionAsyncWithLocation<
    ScenarioConfiguration,
    FixResourcePermissionsRequest,
    PermissionsFix
  >;

  /**
   * Get the latest validation for the scenario.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "LRO polling endpoint that returns body in both 200 and 202"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "LRO polling endpoint returns body in 202 to reflect current status"
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern, not status monitor"
  @summary("Get the latest validation for the scenario configuration.")
  @autoRoute
  @armResourceRead(Validation)
  @get
  getLatestValidation(
    ...ResourceInstanceParameters<Validation>,
  ): ArmResponse<Validation> | (AcceptedResponse & {
    @doc("The Location header contains the URL where the status of the long running operation can be checked.")
    @header("Location")
    location: string;

    @doc("The Retry-After header can indicate how long the client should wait before polling the operation status.")
    @header("Retry-After")
    retryAfter?: int32;

    @bodyRoot body: Validation;
  }) | ErrorResponse;

  /**
   * Get the latest fix resource permissions result for the scenario configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/polling-operation-no-status-monitor" "LRO uses final-state-via:location pattern, not status monitor"
  getLatestPermissionsFix is ArmResourceRead<PermissionsFix>;
}

@@minLength(ScenarioConfiguration.name, 1);
@@doc(ScenarioConfiguration.name, "Name of the scenario definition.");
@@doc(ScenarioConfiguration.properties,
  "The properties of scenario definition."
);

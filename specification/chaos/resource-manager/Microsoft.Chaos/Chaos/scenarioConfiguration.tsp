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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 202 with Location header for polling; final result obtained by polling the Location URL"
  @pollingOperation(ScenarioRuns.get)
  execute is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioConfiguration,
    void,
    ScenarioRun
  >;

  /**
   * Cancel the currently running scenario execution.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 202 with Location header for polling; final result obtained by polling the Location URL"
  @removed(Microsoft.Chaos.Versions.v2026_05_01_preview)
  @pollingOperation(ScenarioRuns.get)
  cancel is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioConfiguration,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult
  >;

  /**
   * Validate the given scenario configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 202 with Location header for polling; final result obtained by polling the Location URL"
  validate is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioConfiguration,
    void,
    Validation
  >;

  /**
   * Fixes resource permissions for the given scenario configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST returns 202 with Location header for polling; final result obtained by polling the Location URL"
  fixResourcePermissions is ArmResourceActionNoContentAsyncWithLocationResult<
    ScenarioConfiguration,
    FixResourcePermissionsRequest,
    PermissionsFix
  >;
}

@@minLength(ScenarioConfiguration.name, 1);
@@doc(ScenarioConfiguration.name, "Name of the scenario definition.");
@@doc(ScenarioConfiguration.properties,
  "The properties of scenario definition."
);

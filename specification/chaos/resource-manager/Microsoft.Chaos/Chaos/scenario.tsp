import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./scenario.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_05_01_preview)
@armResourceOperations
interface Scenarios {
  /**
   * Get a scenario.
   */
  get is ArmResourceRead<Scenario>;

  /**
   * Create or update a scenario.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Scenario>;

  /**
   * Delete a scenario.
   */
  delete is ArmResourceDeleteSync<Scenario>;

  /**
   * Get a list of scenarios.
   */
  listAll is ArmResourceListByParent<Scenario, Response = ScenarioListResult>;
}

@@minLength(Scenario.name, 1);
@@doc(Scenario.name, "Name of the scenario.");
@@doc(Scenario.properties, "The properties of scenario.");

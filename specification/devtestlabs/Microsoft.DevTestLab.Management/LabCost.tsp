import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A cost item.
 */
model LabCost is Azure.ResourceManager.TrackedResource<LabCostProperties> {
  ...ResourceNameParameter<
    Resource = LabCost,
    KeyName = "name",
    SegmentName = "costs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LabCosts {
  /**
   * Get cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Costs_Get")
  get is ArmResourceRead<
    LabCost,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=labCostDetails)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Costs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabCost>;

  /**
   * Delete cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Costs_Delete")
  delete is ArmResourceDeleteSync<LabCost>;
}

@@doc(LabCost.name, "The name of the cost.");
@@doc(LabCost.properties, "The properties of the resource.");
@@doc(LabCosts.createOrUpdate::parameters.resource, "A cost item.");

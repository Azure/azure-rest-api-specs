import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A cost item.
 */
@parentResource(Lab)
model LabCost is Azure.ResourceManager.ProxyResource<LabCostProperties, false> {
  ...ResourceNameParameter<
    Resource = LabCost,
    KeyName = "costName",
    SegmentName = "costs",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface Costs {
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
}

@@doc(LabCost.name, "The name of the cost.");
@@doc(LabCost.properties, "The properties of the resource.");
@@doc(Costs.createOrUpdate::parameters.resource, "A cost item.");

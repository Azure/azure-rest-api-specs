import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A cost item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Private.armResourceInternal(LabCostProperties)
@includeInapplicableMetadataInPayload(false)
model LabCost extends Resource {
  /**
   * The name of the cost.
   */
  @path
  @key("name")
  @segment("costs")
  name: string;

  /**
   * The properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: LabCostProperties;
}

@armResourceOperations
interface LabCosts {
  /**
   * Get cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Costs_Get")
  get is ArmResourceRead<
    LabCost,
    {
      ...BaseParameters<LabCost>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Costs_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabCost>;
}

@@projectedName(LabCosts.createOrUpdate::parameters.resource,
  "json",
  "labCost"
);
@@extension(LabCosts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "labCost"
);
@@doc(LabCosts.createOrUpdate::parameters.resource, "A cost item.");

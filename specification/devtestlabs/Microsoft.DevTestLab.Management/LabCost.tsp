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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@parentResource(Lab)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model LabCost extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("costs")
  name: string;

  properties: LabCostProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
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
}

@@doc(LabCost.name, "The name of the cost.");
@@doc(LabCost.properties, "The properties of the resource.");
@@doc(LabCosts.createOrUpdate::parameters.resource, "A cost item.");
@@doc(LabCost.tags, "The tags of the resource.");
@@doc(LabCost.location, "The location of the resource.");

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
model LabCost
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<
    LabCostProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = LabCost,
    KeyName = "name",
    SegmentName = "costs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LabCostOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = LabCost,
        KeyName = "name",
        SegmentName = "costs",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface Costs {
  /**
   * Get cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Costs_Get")
  get is LabCostOps.Read<
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
  createOrUpdate is LabCostOps.CreateOrUpdateSync<LabCost>;
}

@@doc(LabCost.name, "The name of the cost.");
@@doc(LabCost.properties, "The properties of the resource.");
@@doc(Costs.createOrUpdate::parameters.resource, "A cost item.");

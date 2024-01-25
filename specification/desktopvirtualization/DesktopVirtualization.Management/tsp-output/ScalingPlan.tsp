import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a scaling plan definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ScalingPlanProperties)
model ScalingPlan extends TrackedResourceBase {
  /**
   * The name of the scaling plan.
   */
  @maxLength(64)
  @minLength(3)
  @path
  @key("scalingPlanName")
  @segment("scalingPlans")
  @visibility("read")
  name: string;

  /**
   * Detailed properties for scaling plan.
   */
  @extension("x-ms-client-flatten", true)
  properties: ScalingPlanProperties;
}

@armResourceOperations
interface ScalingPlans {
  /**
   * Get a scaling plan.
   */
  get is ArmResourceRead<ScalingPlan>;

  /**
   * Create or update a scaling plan.
   */
  create is ArmResourceCreateOrReplaceSync<ScalingPlan>;

  /**
   * Update a scaling plan.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ScalingPlan, ScalingPlanPatch>;

  /**
   * Remove a scaling plan.
   */
  delete is ArmResourceDeleteSync<ScalingPlan>;

  /**
   * List scaling plans.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScalingPlans_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ScalingPlan,
    {
      ...BaseParameters<ScalingPlan>;

      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;

  /**
   * List scaling plans in subscription.
   */
  listBySubscription is ArmListBySubscription<ScalingPlan>;
}

@@projectedName(ScalingPlans.create::parameters.resource,
  "json",
  "scalingPlan"
);
@@extension(ScalingPlans.create::parameters.resource,
  "x-ms-client-name",
  "scalingPlan"
);
@@doc(ScalingPlans.create::parameters.resource,
  "Object containing scaling plan definitions."
);
@@projectedName(ScalingPlans.update::parameters.properties,
  "json",
  "scalingPlan"
);
@@extension(ScalingPlans.update::parameters.properties,
  "x-ms-client-name",
  "scalingPlan"
);
@@doc(ScalingPlans.update::parameters.properties,
  "Object containing scaling plan definitions."
);

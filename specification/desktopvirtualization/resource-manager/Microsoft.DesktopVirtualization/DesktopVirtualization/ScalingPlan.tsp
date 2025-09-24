import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a scaling plan definition.
 */
model ScalingPlan
  is Azure.ResourceManager.TrackedResource<ScalingPlanProperties, false> {
  ...ResourceNameParameter<
    Resource = ScalingPlan,
    KeyName = "scalingPlanName",
    SegmentName = "scalingPlans",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ScalingPlan,
    ScalingPlanPatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot scalingPlan?: ScalingPlanPatch;
    }
  >;

  /**
   * Remove a scaling plan.
   */
  delete is ArmResourceDeleteSync<ScalingPlan>;

  /**
   * List scaling plans.
   */
  listByResourceGroup is ArmResourceListByParent<
    ScalingPlan,
    Parameters = {
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
    },
    Response = ScalingPlanList
  >;

  /**
   * List scaling plans in subscription.
   */
  listBySubscription is ArmListBySubscription<
    ScalingPlan,
    Parameters = {
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
    },
    Response = ScalingPlanList
  >;

  /**
   * List scaling plan associated with hostpool.
   */
  @get
  @action("scalingPlans")
  @list
  listByHostPool is Azure.ResourceManager.ArmResourceActionSync<
    HostPool,
    void,
    ScalingPlanList,
    Parameters = {
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
}

@@maxLength(ScalingPlan.name, 64);
@@minLength(ScalingPlan.name, 3);
@@doc(ScalingPlan.name, "The name of the scaling plan.");
@@doc(ScalingPlan.properties, "Detailed properties for scaling plan.");
@@doc(ScalingPlans.create::parameters.resource,
  "Object containing scaling plan definitions."
);

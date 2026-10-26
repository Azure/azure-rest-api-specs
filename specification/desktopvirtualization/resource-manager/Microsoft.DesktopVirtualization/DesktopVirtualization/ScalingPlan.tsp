import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a scaling plan definition.
 */
model ScalingPlan is Azure.ResourceManager.TrackedResource<
  ScalingPlanProperties,
  false
> {
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
  update is ArmCustomPatchSyncWithOptionalBody<ScalingPlan, ScalingPlanPatch>;

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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.pageSize retains the pageSize query parameter; preserve wire compatibility."
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.isDescending retains the isDescending query parameter; preserve wire compatibility."
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.initialSkip retains the initialSkip query parameter; preserve wire compatibility."
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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySubscription.pageSize retains the pageSize query parameter; preserve wire compatibility."
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySubscription.isDescending retains the isDescending query parameter; preserve wire compatibility."
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listBySubscription.initialSkip retains the initialSkip query parameter; preserve wire compatibility."
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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByHostPool.pageSize retains the pageSize query parameter; preserve wire compatibility."
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByHostPool.isDescending retains the isDescending query parameter; preserve wire compatibility."
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByHostPool.initialSkip retains the initialSkip query parameter; preserve wire compatibility."
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}

@@maxLength(ScalingPlan.name, 64);
@@minLength(ScalingPlan.name, 3);
@@doc(ScalingPlan.name, "The name of the scaling plan.");
@@doc(ScalingPlan.properties, "Detailed properties for scaling plan.");
@@doc(
  ScalingPlans.create::parameters.resource,
  "Object containing scaling plan definitions."
);
@@clientName(ScalingPlans.update::parameters.body, "scalingPlan");

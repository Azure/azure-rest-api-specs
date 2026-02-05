import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ScalingPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a ScalingPlanPersonalSchedule definition.
 */
@parentResource(ScalingPlan)
model ScalingPlanPersonalSchedule
  is Azure.ResourceManager.ProxyResource<
    ScalingPlanPersonalScheduleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ScalingPlanPersonalSchedule,
    KeyName = "scalingPlanScheduleName",
    SegmentName = "personalSchedules",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface ScalingPlanPersonalSchedules {
  /**
   * Get a ScalingPlanPersonalSchedule.
   */
  get is ArmResourceRead<ScalingPlanPersonalSchedule>;

  /**
   * Create or update a ScalingPlanPersonalSchedule.
   */
  create is ArmResourceCreateOrReplaceSync<ScalingPlanPersonalSchedule>;

  /**
   * Update a ScalingPlanPersonalSchedule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ScalingPlanPersonalSchedule,
    ScalingPlanPersonalSchedulePatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot scalingPlanSchedule?: ScalingPlanPersonalSchedulePatch;
    }
  >;

  /**
   * Remove a ScalingPlanPersonalSchedule.
   */
  delete is ArmResourceDeleteSync<ScalingPlanPersonalSchedule>;

  /**
   * List ScalingPlanPersonalSchedules.
   */
  list is ArmResourceListByParent<
    ScalingPlanPersonalSchedule,
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
    Response = ScalingPlanPersonalScheduleList
  >;
}

@@maxLength(ScalingPlanPersonalSchedule.name, 64);
@@minLength(ScalingPlanPersonalSchedule.name, 1);
@@doc(ScalingPlanPersonalSchedule.name, "The name of the ScalingPlanSchedule");
@@doc(ScalingPlanPersonalSchedule.properties,
  "Detailed properties for ScalingPlanPersonalSchedule"
);
@@doc(ScalingPlanPersonalSchedules.create::parameters.resource,
  "Object containing ScalingPlanPersonalSchedule definitions."
);

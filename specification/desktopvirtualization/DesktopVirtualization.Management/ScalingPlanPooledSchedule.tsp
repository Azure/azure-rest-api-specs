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
 * Represents a ScalingPlanPooledSchedule definition.
 */
@parentResource(ScalingPlan)
model ScalingPlanPooledSchedule
  is Azure.ResourceManager.ProxyResource<
    ScalingPlanPooledScheduleProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = ScalingPlanPooledSchedule,
    KeyName = "scalingPlanScheduleName",
    SegmentName = "pooledSchedules",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface ScalingPlanPooledSchedules {
  /**
   * Get a ScalingPlanPooledSchedule.
   */
  get is ArmResourceRead<ScalingPlanPooledSchedule>;

  /**
   * Create or update a ScalingPlanPooledSchedule.
   */
  create is ArmResourceCreateOrReplaceSync<ScalingPlanPooledSchedule>;

  /**
   * Update a ScalingPlanPooledSchedule.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ScalingPlanPooledSchedule,
    ScalingPlanPooledSchedulePatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot scalingPlanSchedule?: ScalingPlanPooledSchedulePatch;
    }
  >;

  /**
   * Remove a ScalingPlanPooledSchedule.
   */
  delete is ArmResourceDeleteSync<ScalingPlanPooledSchedule>;

  /**
   * List ScalingPlanPooledSchedules.
   */
  list is ArmResourceListByParent<
    ScalingPlanPooledSchedule,
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
    Response = ScalingPlanPooledScheduleList
  >;
}

@@maxLength(ScalingPlanPooledSchedule.name, 64);
@@minLength(ScalingPlanPooledSchedule.name, 1);
@@doc(ScalingPlanPooledSchedule.name, "The name of the ScalingPlanSchedule");
@@doc(ScalingPlanPooledSchedule.properties,
  "Detailed properties for ScalingPlanPooledSchedule"
);
@@doc(ScalingPlanPooledSchedules.create::parameters.resource,
  "Object containing ScalingPlanPooledSchedule definitions."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ScalingPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a ScalingPlanPooledSchedule definition.
 */
@parentResource(ScalingPlan)
model ScalingPlanPooledSchedule
  is ProxyResource<ScalingPlanPooledScheduleProperties> {
  /**
   * The name of the ScalingPlanSchedule
   */
  @maxLength(64)
  @minLength(1)
  @path
  @key("scalingPlanScheduleName")
  @segment("pooledSchedules")
  name: string;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    ScalingPlanPooledSchedule,
    ScalingPlanPooledSchedulePatch
  >;

  /**
   * Remove a ScalingPlanPooledSchedule.
   */
  delete is ArmResourceDeleteSync<ScalingPlanPooledSchedule>;

  /**
   * List ScalingPlanPooledSchedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScalingPlanPooledSchedules_List")
  list is ArmResourceListByParent<
    ScalingPlanPooledSchedule,
    {
      ...BaseParameters<ScalingPlanPooledSchedule>;

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

@@projectedName(ScalingPlanPooledSchedules.create::parameters.resource,
  "json",
  "scalingPlanSchedule"
);
@@extension(ScalingPlanPooledSchedules.create::parameters.resource,
  "x-ms-client-name",
  "scalingPlanSchedule"
);
@@doc(ScalingPlanPooledSchedules.create::parameters.resource,
  "Object containing ScalingPlanPooledSchedule definitions."
);
@@projectedName(ScalingPlanPooledSchedules.update::parameters.properties,
  "json",
  "scalingPlanSchedule"
);
@@extension(ScalingPlanPooledSchedules.update::parameters.properties,
  "x-ms-client-name",
  "scalingPlanSchedule"
);
@@doc(ScalingPlanPooledSchedules.update::parameters.properties,
  "Object containing ScalingPlanPooledSchedule definitions."
);

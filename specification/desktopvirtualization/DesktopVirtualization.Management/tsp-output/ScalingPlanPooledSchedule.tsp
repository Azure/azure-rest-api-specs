import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ScalingPlan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
@doc("Represents a ScalingPlanPooledSchedule definition.")
@parentResource(ScalingPlan)
model ScalingPlanPooledSchedule
  is ProxyResource<ScalingPlanPooledScheduleProperties> {
  @doc("The name of the ScalingPlanSchedule")
  @maxLength(64)
  @minLength(1)
  @key("scalingPlanScheduleName")
  @segment("pooledSchedules")
  name: string;
}

@armResourceOperations
interface ScalingPlanPooledSchedules {
  @doc("Get a ScalingPlanPooledSchedule.")
  get is ArmResourceRead<ScalingPlanPooledSchedule>;

  @doc("Create or update a ScalingPlanPooledSchedule.")
  create is ArmResourceCreateOrReplaceSync<ScalingPlanPooledSchedule>;

  @doc("Update a ScalingPlanPooledSchedule.")
  update is ArmCustomPatchSync<
    ScalingPlanPooledSchedule,
    ScalingPlanPooledSchedulePatch
  >;

  @doc("Remove a ScalingPlanPooledSchedule.")
  delete is ArmResourceDeleteSync<ScalingPlanPooledSchedule>;

  @doc("List ScalingPlanPooledSchedules.")
  list is ArmResourceListByParent<
    ScalingPlanPooledSchedule,
    {
      ...BaseParameters<ScalingPlanPooledSchedule>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}

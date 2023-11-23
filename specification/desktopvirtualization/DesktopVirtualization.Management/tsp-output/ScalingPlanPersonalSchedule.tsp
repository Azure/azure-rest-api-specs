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
@doc("Represents a ScalingPlanPersonalSchedule definition.")
@parentResource(ScalingPlan)
model ScalingPlanPersonalSchedule
  is ProxyResource<ScalingPlanPersonalScheduleProperties> {
  @doc("The name of the ScalingPlanSchedule")
  @maxLength(64)
  @minLength(1)
  @path
  @key("scalingPlanScheduleName")
  @segment("personalSchedules")
  name: string;
}

@armResourceOperations
interface ScalingPlanPersonalSchedules {
  @doc("Get a ScalingPlanPersonalSchedule.")
  get is ArmResourceRead<ScalingPlanPersonalSchedule>;
  @doc("Create or update a ScalingPlanPersonalSchedule.")
  create is ArmResourceCreateOrReplaceSync<ScalingPlanPersonalSchedule>;
  @doc("Update a ScalingPlanPersonalSchedule.")
  update is ArmResourcePatchSync<
    ScalingPlanPersonalSchedule,
    ScalingPlanPersonalScheduleProperties
  >;
  @doc("Remove a ScalingPlanPersonalSchedule.")
  delete is ArmResourceDeleteSync<ScalingPlanPersonalSchedule>;
  @doc("List ScalingPlanPersonalSchedules.")
  list is ArmResourceListByParent<
    ScalingPlanPersonalSchedule,
    {
      ...BaseParameters<ScalingPlanPersonalSchedule>;

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

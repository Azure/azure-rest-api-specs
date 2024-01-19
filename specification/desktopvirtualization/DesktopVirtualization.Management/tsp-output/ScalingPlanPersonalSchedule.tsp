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
  update is ArmCustomPatchSync<
    ScalingPlanPersonalSchedule,
    ScalingPlanPersonalSchedulePatch
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

@@projectedName(ScalingPlanPersonalSchedules.create::parameters.resource,
  "json",
  "scalingPlanSchedule"
);
@@extension(ScalingPlanPersonalSchedules.create::parameters.resource,
  "x-ms-client-name",
  "scalingPlanSchedule"
);
@@doc(ScalingPlanPersonalSchedules.create::parameters.resource,
  "Object containing ScalingPlanPersonalSchedule definitions."
);
@@projectedName(ScalingPlanPersonalSchedules.update::parameters.properties,
  "json",
  "scalingPlanSchedule"
);
@@extension(ScalingPlanPersonalSchedules.update::parameters.properties,
  "x-ms-client-name",
  "scalingPlanSchedule"
);
@@doc(ScalingPlanPersonalSchedules.update::parameters.properties,
  "Object containing ScalingPlanPersonalSchedule definitions."
);

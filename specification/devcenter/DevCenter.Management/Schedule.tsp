import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Pool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("Represents a Schedule to execute a task.")
@parentResource(Pool)
model Schedule is Azure.ResourceManager.ProxyResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "scheduleName",
    SegmentName = "schedules",
    NamePattern = "^[-\\w]+$"
  >;
}

@armResourceOperations
interface Schedules {
  @doc("Gets a schedule resource.")
  get is ArmResourceRead<Schedule>;

  @doc("Creates or updates a Schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Schedule,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Partially updates a Schedule.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Schedule,
    PatchModel = ScheduleUpdate,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    LroHeaders = ArmLroLocationHeader,
    Response = Schedule | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = Schedule>
    >
  >;

  @doc("Deletes a Schedule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Schedule,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists schedules for a pool.")
  listByPool is ArmResourceListByParent<
    Schedule,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = ScheduleListResult
  >;
}

@@maxLength(Schedule.name, 100);
@@minLength(Schedule.name, 1);
@@doc(Schedule.name, "The name of the schedule that uniquely identifies it.");
@@doc(Schedule.properties, "Properties of a Schedule resource");
@@doc(Schedules.createOrUpdate::parameters.resource,
  "Represents a scheduled task"
);
@@doc(Schedules.update::parameters.properties, "Represents a scheduled task.");

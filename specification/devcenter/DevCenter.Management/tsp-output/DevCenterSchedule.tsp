import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a Schedule to execute a task.")
@parentResource(DevCenterPool)
model DevCenterSchedule is ProxyResource<ScheduleProperties> {
  @doc("The name of the schedule that uniquely identifies it.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w]+$")
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface DevCenterSchedules {
  @doc("Gets a schedule resource.")
  get is ArmResourceRead<
    DevCenterSchedule,
    {
      ...BaseParameters<DevCenterSchedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Creates or updates a Schedule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DevCenterSchedule,
    {
      ...BaseParameters<DevCenterSchedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Partially updates a Scheduled.")
  update is ArmResourcePatchAsync<
    DevCenterSchedule,
    ScheduleProperties,
    {
      ...BaseParameters<DevCenterSchedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Deletes a Scheduled.")
  delete is ArmResourceDeleteAsync<
    DevCenterSchedule,
    {
      ...BaseParameters<DevCenterSchedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists schedules for a pool")
  listByPool is ArmResourceListByParent<
    DevCenterSchedule,
    {
      ...BaseParameters<DevCenterSchedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

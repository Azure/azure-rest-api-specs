import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Pool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Represents a Schedule to execute a task.")
@parentResource(Pool)
model Schedule is ProxyResource<ScheduleProperties> {
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
interface Schedules {
  @doc("Gets a schedule resource.")
  get is ArmResourceRead<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Creates or updates a Schedule.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Partially updates a Scheduled.")
  update is ArmResourcePatchAsync<
    Schedule,
    ScheduleProperties,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Deletes a Scheduled.")
  delete is ArmResourceDeleteAsync<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Lists schedules for a pool")
  listByPool is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}

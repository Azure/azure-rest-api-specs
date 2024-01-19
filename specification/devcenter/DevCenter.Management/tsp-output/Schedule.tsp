import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Pool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
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
    },
    ArmAsyncOperationHeader
  >;

  @doc("Partially updates a Scheduled.")
  update is ArmCustomPatchAsync<
    Schedule,
    ScheduleUpdate,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a Scheduled.")
  delete is ArmResourceDeleteAsync<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    ArmAsyncOperationHeader
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

@@projectedName(Schedules.createOrUpdate::parameters.resource, "json", "body");
@@extension(Schedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.createOrUpdate::parameters.resource,
  "Represents a scheduled task"
);
@@projectedName(Schedules.update::parameters.properties, "json", "body");
@@extension(Schedules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.update::parameters.properties, "Represents a scheduled task.");

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
/**
 * Represents a Schedule to execute a task.
 */
@parentResource(Pool)
model Schedule is ProxyResource<ScheduleProperties> {
  /**
   * The name of the schedule that uniquely identifies it.
   */
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
  /**
   * Gets a schedule resource.
   */
  get is ArmResourceRead<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Creates or updates a Schedule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a Scheduled.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Schedule,
    ScheduleUpdate,
    {
      ...BaseParameters<Schedule>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a Scheduled.
   */
  delete is ArmResourceDeleteAsync<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Lists schedules for a pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedules_ListByPool")
  listByPool is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
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

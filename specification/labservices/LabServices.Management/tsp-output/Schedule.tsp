import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Schedule for automatically turning virtual machines in a lab on and off at specified times.
 */
@parentResource(Lab)
model Schedule is ProxyResource<ScheduleProperties> {
  /**
   * The name of the schedule that uniquely identifies it within containing lab. Used in resource URIs.
   */
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface Schedules {
  /**
   * Returns the properties of a lab Schedule.
   */
  get is ArmResourceRead<Schedule>;

  /**
   * Operation to create or update a lab schedule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  /**
   * Operation to update a lab schedule.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Schedule, ScheduleUpdate>;

  /**
   * Operation to delete a schedule resource.
   */
  delete is ArmResourceDeleteAsync<
    Schedule,
    BaseParameters<Schedule>,
    ArmLroLocationHeader
  >;

  /**
   * Returns a list of all schedules for a lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Schedules_ListByLab")
  listByLab is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Schedules.createOrUpdate::parameters.resource, "json", "body");
@@extension(Schedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Schedules.update::parameters.properties, "json", "body");
@@extension(Schedules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.update::parameters.properties, "The request body.");

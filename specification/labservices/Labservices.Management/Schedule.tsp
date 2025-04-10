import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * Schedule for automatically turning virtual machines in a lab on and off at specified times.
 */
@parentResource(Lab)
model Schedule
  is Azure.ResourceManager.ProxyResource<ScheduleProperties, false> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "scheduleName",
    SegmentName = "schedules",
    NamePattern = "^[-\\w\\\\._\\\\(\\\\)]+$"
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Schedule, PatchModel = ScheduleUpdate>;

  /**
   * Operation to delete a schedule resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Schedule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of all schedules for a lab.
   */
  listByLab is ArmResourceListByParent<
    Schedule,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedSchedules>
  >;
}

@@maxLength(Schedule.name, 100);
@@minLength(Schedule.name, 1);
@@doc(Schedule.name,
  "The name of the schedule that uniquely identifies it within containing lab. Used in resource URIs."
);
@@doc(Schedule.properties, "Schedule resource properties");
@@doc(Schedules.createOrUpdate::parameters.resource, "The request body.");
@@doc(Schedules.update::parameters.properties, "The request body.");

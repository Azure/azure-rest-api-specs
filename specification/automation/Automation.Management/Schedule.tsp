import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the schedule.
 */
@parentResource(AutomationAccount)
model Schedule is Azure.ResourceManager.ProxyResource<ScheduleProperties> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "scheduleName",
    SegmentName = "schedules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Schedules {
  /**
   * Retrieve the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Schedule_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/scheduleoperations")
  get is ArmResourceRead<Schedule>;

  /**
   * Create a schedule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Schedule_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/scheduleoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Schedule,
    Request = ScheduleCreateOrUpdateParameters,
    Response = ArmResourceUpdatedResponse<Schedule> | ArmResourceCreatedSyncResponse<Schedule> | ConflictResponse
  >;

  /**
   * Update the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Schedule_Update")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/scheduleoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Schedule, PatchModel = ScheduleUpdateParameters>;

  /**
   * Delete the schedule identified by schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Schedule_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/scheduleoperations")
  delete is ArmResourceDeleteSync<Schedule, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of schedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Schedule_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/scheduleoperations")
  listByAutomationAccount is ArmResourceListByParent<Schedule>;
}

@@doc(Schedule.name, "The schedule name.");
@@doc(Schedule.properties, "Gets or sets the properties of the schedule.");
@@doc(Schedules.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update schedule operation."
);
@@doc(Schedules.update::parameters.properties,
  "The parameters supplied to the update schedule operation."
);

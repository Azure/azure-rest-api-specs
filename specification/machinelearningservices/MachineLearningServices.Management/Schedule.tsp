import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model Schedule
  is Azure.ResourceManager.ProxyResource<ScheduleProperties, false> {
  ...ResourceNameParameter<
    Resource = Schedule,
    KeyName = "name",
    SegmentName = "schedules",
    NamePattern = ""
  >;
}

alias SchedulesListParameters = {
  /**
   * Continuation token for pagination.
   */
  @query("$skip")
  $skip?: string;

  /**
   * Status filter for schedule.
   */
  @query("listViewType")
  listViewType?: ScheduleListViewType = ScheduleListViewType.EnabledOnly;
};

@armResourceOperations
interface Schedules {
  /**
   * Get schedule.
   */
  @summary("Get schedule.")
  get is ArmResourceRead<Schedule>;

  /**
   * Create or update schedule.
   */
  @summary("Create or update schedule.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Schedule,
    Response = ArmResourceUpdatedResponse<Schedule> | (ArmResourceCreatedResponse<
      Schedule,
      LroHeaders = ArmAsyncOperationHeader<Schedule>
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Delete schedule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete schedule.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Schedule,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List schedules in specified workspace.
   */
  @summary("List schedules in specified workspace.")
  list is ArmResourceListByParent<
    Schedule,
    Parameters = SchedulesListParameters,
    Response = ArmResponse<ScheduleResourceArmPaginatedResult>
  >;
}

@@doc(Schedule.name, "Schedule name.");
@@doc(Schedule.properties, "[Required] Additional attributes of the entity.");
@@doc(Schedules.createOrUpdate::parameters.resource, "Schedule definition.");

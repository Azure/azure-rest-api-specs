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
 * Definition of the job schedule.
 */
@parentResource(AutomationAccount)
model JobSchedule
  is Azure.ResourceManager.ProxyResource<JobScheduleProperties> {
  ...ResourceNameParameter<
    Resource = JobSchedule,
    KeyName = "jobScheduleId",
    SegmentName = "jobSchedules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobSchedules {
  /**
   * Retrieve the job schedule identified by job schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobSchedule_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/jobscheduleoperations")
  get is ArmResourceRead<JobSchedule>;

  /**
   * Create a job schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("JobSchedule_Create")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/jobscheduleoperations")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    JobSchedule,
    Request = JobScheduleCreateParameters,
    Response = ArmResourceCreatedSyncResponse<JobSchedule>
  >;

  /**
   * Delete the job schedule identified by job schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("JobSchedule_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/jobscheduleoperations")
  delete is ArmResourceDeleteSync<JobSchedule, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of job schedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("JobSchedule_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/jobscheduleoperations")
  listByAutomationAccount is ArmResourceListByParent<
    JobSchedule,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format"
@@format(JobSchedule.name, "uuid");
@@doc(JobSchedule.name, "The job schedule name.");
@@doc(JobSchedule.properties,
  "Gets or sets the properties of the job schedule."
);
@@doc(JobSchedules.create::parameters.resource,
  "The parameters supplied to the create job schedule operation."
);

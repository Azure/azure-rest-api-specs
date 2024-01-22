import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the job schedule.
 */
@parentResource(AutomationAccount)
model JobSchedule is ProxyResource<JobScheduleProperties> {
  /**
   * The job schedule name.
   */
  @path
  @key("jobScheduleId")
  @segment("jobSchedules")
  name: string;
}

@armResourceOperations
interface JobSchedules {
  /**
   * Retrieve the job schedule identified by job schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobSchedule_Get")
  get is ArmResourceRead<JobSchedule>;

  /**
   * Create a job schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobSchedule_Create")
  create is ArmResourceCreateOrReplaceSync<JobSchedule>;

  /**
   * Delete the job schedule identified by job schedule name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobSchedule_Delete")
  delete is ArmResourceDeleteSync<JobSchedule>;

  /**
   * Retrieve a list of job schedules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobSchedule_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    JobSchedule,
    {
      ...BaseParameters<JobSchedule>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(JobSchedules.create::parameters.resource, "json", "parameters");
@@extension(JobSchedules.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(JobSchedules.create::parameters.resource,
  "The parameters supplied to the create job schedule operation."
);

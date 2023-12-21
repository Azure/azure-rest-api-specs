import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the job schedule.")
@parentResource(AutomationAccount)
model JobSchedule is ProxyResource<JobScheduleProperties> {
  @doc("The job schedule name.")
  @path
  @key("jobScheduleId")
  @segment("jobSchedules")
  name: string;
}

@armResourceOperations
interface JobSchedule {
  @doc("Retrieve the job schedule identified by job schedule name.")
  get is ArmResourceRead<JobSchedule>;
  @doc("Create a job schedule.")
  create is ArmResourceCreateOrReplaceSync<JobSchedule>;
  @doc("Delete the job schedule identified by job schedule name.")
  delete is ArmResourceDeleteSync<JobSchedule>;
  @doc("Retrieve a list of job schedules.")
  listByAutomationAccount is ArmResourceListByParent<
    JobSchedule,
    {
      ...BaseParameters<JobSchedule>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

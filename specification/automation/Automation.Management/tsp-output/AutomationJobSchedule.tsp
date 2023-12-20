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
model AutomationJobSchedule is ProxyResource<JobScheduleProperties> {
  @doc("The job schedule name.")
  @path
  @key("jobScheduleId")
  @segment("jobSchedules")
  name: string;
}

@armResourceOperations
interface AutomationJobSchedules {
  @doc("Retrieve the job schedule identified by job schedule name.")
  get is ArmResourceRead<AutomationJobSchedule>;
  @doc("Create a job schedule.")
  create is ArmResourceCreateOrReplaceSync<AutomationJobSchedule>;
  @doc("Delete the job schedule identified by job schedule name.")
  delete is ArmResourceDeleteSync<AutomationJobSchedule>;
  @doc("Retrieve a list of job schedules.")
  listByAutomationAccount is ArmResourceListByParent<
    AutomationJobSchedule,
    {
      ...BaseParameters<AutomationJobSchedule>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

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
@doc("Definition of the schedule.")
@parentResource(AutomationAccount)
model AutomationSchedule is ProxyResource<ScheduleProperties> {
  @doc("The schedule name.")
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface AutomationSchedules {
  @doc("Retrieve the schedule identified by schedule name.")
  get is ArmResourceRead<AutomationSchedule>;
  @doc("Create a schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationSchedule>;
  @doc("Update the schedule identified by schedule name.")
  update is ArmResourcePatchSync<AutomationSchedule, ScheduleProperties>;
  @doc("Delete the schedule identified by schedule name.")
  delete is ArmResourceDeleteSync<AutomationSchedule>;
  @doc("Retrieve a list of schedules.")
  listByAutomationAccount is ArmResourceListByParent<AutomationSchedule>;
}

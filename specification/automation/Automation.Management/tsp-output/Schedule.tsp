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
model Schedule is ProxyResource<ScheduleProperties> {
  @doc("The schedule name.")
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface Schedule {
  @doc("Retrieve the schedule identified by schedule name.")
  get is ArmResourceRead<Schedule>;
  @doc("Create a schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;
  @doc("Update the schedule identified by schedule name.")
  update is ArmCustomPatchSync<Schedule, ScheduleUpdateParameters>;
  @doc("Delete the schedule identified by schedule name.")
  delete is ArmResourceDeleteSync<Schedule>;
  @doc("Retrieve a list of schedules.")
  listByAutomationAccount is ArmResourceListByParent<Schedule>;
}

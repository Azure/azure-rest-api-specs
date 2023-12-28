import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Managed instance's Start/Stop schedule.")
@parentResource(ManagedInstance)
model StartStopManagedInstanceSchedule
  is ProxyResource<StartStopManagedInstanceScheduleProperties> {
  @doc("Name of the managed instance Start/Stop schedule.")
  @key("startStopScheduleName")
  @segment("startStopSchedules")
  name: StartStopScheduleName;
}

@armResourceOperations
interface StartStopManagedInstanceSchedules {
  @doc("Gets the managed instance's Start/Stop schedule.")
  get is ArmResourceRead<StartStopManagedInstanceSchedule>;
  @doc("Creates or updates the managed instance's Start/Stop schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StartStopManagedInstanceSchedule>;
  @doc("Deletes the managed instance's Start/Stop schedule.")
  delete is ArmResourceDeleteSync<StartStopManagedInstanceSchedule>;
  @doc("Lists the managed instance's Start/Stop schedules.")
  listByInstance is ArmResourceListByParent<StartStopManagedInstanceSchedule>;
}

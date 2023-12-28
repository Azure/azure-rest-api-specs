import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("""
The task run that has the ARM resource and properties. 
The task run will have the information of request and result of a run.
""")
@parentResource(Registry)
model TaskRun is ProxyResource<TaskRunProperties> {
  @doc("The name of the task run.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-]*$")
  @key("taskRunName")
  @segment("taskRuns")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface TaskRuns {
  @doc("Gets the detailed information for a given task run.")
  get is ArmResourceRead<TaskRun>;
  @doc("Creates a task run for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<TaskRun>;
  @doc("Updates a task run with the specified parameters.")
  update is ArmCustomPatchAsync<TaskRun, TaskRunUpdateParameters>;
  @doc("Deletes a specified task run resource.")
  delete is ArmResourceDeleteAsync<TaskRun>;
  @doc("Lists all the task runs for a specified container registry.")
  list is ArmResourceListByParent<TaskRun>;
  @doc("Gets the detailed information for a given task run that includes all secrets.")
  getDetails is ArmResourceActionSync<TaskRun, void, TaskRun>;
}

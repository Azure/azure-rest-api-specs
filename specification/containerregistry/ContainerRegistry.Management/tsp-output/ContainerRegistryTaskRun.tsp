import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerRegistry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ContainerRegistry;
@doc("""
The task run that has the ARM resource and properties. 
The task run will have the information of request and result of a run.
""")
@parentResource(ContainerRegistry)
model ContainerRegistryTaskRun is ProxyResource<TaskRunProperties> {
  @doc("The name of the task run.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-]*$")
  @path
  @key("taskRunName")
  @segment("taskRuns")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ContainerRegistryTaskRuns {
  @doc("Gets the detailed information for a given task run.")
  get is ArmResourceRead<ContainerRegistryTaskRun>;
  @doc("Creates a task run for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistryTaskRun>;
  @doc("Updates a task run with the specified parameters.")
  update is ArmResourcePatchAsync<ContainerRegistryTaskRun, TaskRunProperties>;
  @doc("Deletes a specified task run resource.")
  delete is ArmResourceDeleteAsync<ContainerRegistryTaskRun>;
  @doc("Lists all the task runs for a specified container registry.")
  list is ArmResourceListByParent<ContainerRegistryTaskRun>;
  @doc("Gets the detailed information for a given task run that includes all secrets.")
  getDetails is ArmResourceActionSync<
    ContainerRegistryTaskRun,
    void,
    ContainerRegistryTaskRun
  >;
}

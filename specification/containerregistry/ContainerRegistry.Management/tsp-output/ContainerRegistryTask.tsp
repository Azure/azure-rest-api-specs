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
The task that has the ARM resource and task properties. 
The task will have all information to schedule a run against it.
""")
@parentResource(ContainerRegistry)
model ContainerRegistryTask is TrackedResource<TaskProperties> {
  @doc("The name of the container registry task.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-_]*$")
  @path
  @key("taskName")
  @segment("tasks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ContainerRegistryTasks {
  @doc("Get the properties of a specified task.")
  get is ArmResourceRead<ContainerRegistryTask>;
  @doc("Creates a task for a container registry with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ContainerRegistryTask>;
  @doc("Updates a task with the specified parameters.")
  update is ArmResourcePatchAsync<ContainerRegistryTask, TaskProperties>;
  @doc("Deletes a specified task.")
  delete is ArmResourceDeleteAsync<ContainerRegistryTask>;
  @doc("Lists all the tasks for a specified container registry.")
  list is ArmResourceListByParent<ContainerRegistryTask>;
  @doc("Returns a task with extended information that includes all secrets.")
  getDetails is ArmResourceActionSync<
    ContainerRegistryTask,
    void,
    ContainerRegistryTask
  >;
}
